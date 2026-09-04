[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('status_semanal', 'status_operacional', 'decisao_escopo', 'alerta_custo_prioridade', 'alerta_tecnico', 'marco_aceite', 'prontidao_go_live')]
    [string]$Tipo,

    [Parameter(Mandatory = $true)]
    [string[]]$Para,

    [switch]$Preview,
    [switch]$Send,
    [string]$ApprovedBodyPath,
    [string]$Subject
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = Split-Path -Parent $PSScriptRoot
$StatusPath = Join-Path $ProjectRoot 'gestao\status-atual.md'
$OutboxPath = Join-Path $PSScriptRoot 'outbox'
$LogPath = Join-Path $PSScriptRoot 'logs'

function Encode-Html([string]$Value) {
    return [System.Net.WebUtility]::HtmlEncode($Value)
}

function Get-Metadata([string]$Content, [string]$Name) {
    $match = [regex]::Match($Content, "(?m)^\*\*$([regex]::Escape($Name)):\*\*\s*(.+)$")
    if ($match.Success) { return $match.Groups[1].Value.Trim() }
    return 'Information pending update'
}

function Get-SectionItems([string]$Content, [string]$Heading) {
    $escapedHeading = [regex]::Escape($Heading)
    $match = [regex]::Match($Content, "(?ms)^##\s+$escapedHeading\s*$\r?\n(?<section>.*?)(?=^##\s+|\z)")
    if (-not $match.Success) { return @('Information pending update') }

    $items = [regex]::Matches($match.Groups['section'].Value, '(?m)^-\s+(.+)$') |
        ForEach-Object { $_.Groups[1].Value.Trim() } |
        Where-Object { $_ -and $_ -ne 'A definir.' }

    if ($items.Count -eq 0) { return @('Information pending update') }
    return @($items)
}

function Convert-ItemsToHtml([string[]]$Items) {
    $listItems = $Items | ForEach-Object { "<li>$(Encode-Html $_)</li>" }
    return "<ul>$($listItems -join '')</ul>"
}

if (-not (Test-Path $StatusPath)) {
    throw "Status file not found: $StatusPath"
}

New-Item -ItemType Directory -Path $OutboxPath, $LogPath -Force | Out-Null
$Status = Get-Content -Raw -Path $StatusPath -Encoding UTF8
$Date = Get-Metadata $Status 'Data de referencia'
$Phase = Get-Metadata $Status 'Fase atual'
$Semaphore = Get-Metadata $Status 'Semaforo'
$Summary = Get-SectionItems $Status 'Resumo executivo'
$Completed = Get-SectionItems $Status 'Concluido desde o ultimo status'
$NextSteps = Get-SectionItems $Status 'Proximos passos'
$Risks = Get-SectionItems $Status 'Riscos e dependencias'
$Decisions = Get-SectionItems $Status 'Decisoes necessarias'
$Notes = Get-SectionItems $Status 'Observacoes'

$DefaultSubjects = @{
    status_semanal = "[Projetos][Status semanal] $Date - $Phase"
    status_operacional = "[Projetos][Status operacional] $Date - $Phase"
    decisao_escopo = "[Projetos][Decisao de escopo] $Phase"
    alerta_custo_prioridade = "[Projetos][Alerta de custo/prioridade] $Phase"
    alerta_tecnico = "[Projetos][Alerta tecnico] $Phase"
    marco_aceite = "[Projetos][Marco] Aceite solicitado - $Phase"
    prontidao_go_live = "[Projetos][Go-Live] Prontidao para autorizacao"
}

if ([string]::IsNullOrWhiteSpace($Subject)) { $Subject = $DefaultSubjects[$Tipo] }

if ($ApprovedBodyPath) {
    if (-not (Test-Path $ApprovedBodyPath)) { throw "Approved body not found: $ApprovedBodyPath" }
    $HtmlBody = Get-Content -Raw -Path $ApprovedBodyPath -Encoding UTF8
}
else {
    $HtmlBody = @"
<html><body style="font-family:Segoe UI,Arial,sans-serif;color:#1f2937;line-height:1.5">
<h2>Status do Projeto</h2>
<p><strong>Data de referencia:</strong> $(Encode-Html $Date)<br/>
<strong>Fase atual:</strong> $(Encode-Html $Phase)<br/>
<strong>Semaforo:</strong> $(Encode-Html $Semaphore)</p>
<h3>Resumo executivo</h3>$(Convert-ItemsToHtml $Summary)
<h3>Conclu&#237;do desde o &#250;ltimo status</h3>$(Convert-ItemsToHtml $Completed)
<h3>Pr&#243;ximos passos</h3>$(Convert-ItemsToHtml $NextSteps)
<h3>Riscos e depend&#234;ncias</h3>$(Convert-ItemsToHtml $Risks)
<h3>Decisoes necessarias</h3>$(Convert-ItemsToHtml $Decisions)
<h3>Observa&#231;&#245;es</h3>$(Convert-ItemsToHtml $Notes)
<p><em>Rascunho gerado a partir de gestao/status-atual.md. Revise antes do envio.</em></p>
</body></html>
"@
}

$Timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$PreviewPath = Join-Path $OutboxPath "${Timestamp}-${Tipo}.html"
Set-Content -Path $PreviewPath -Value $HtmlBody -Encoding utf8
Write-Host "Preview created at: $PreviewPath"

if (-not $Send) {
    Write-Host 'No email was sent. Use -Send after reviewing the preview.'
    return
}

$ZeptoToken = [Environment]::GetEnvironmentVariable('ZEPTO_API_TOKEN', 'Machine')
if ([string]::IsNullOrWhiteSpace($ZeptoToken)) {
    $ZeptoToken = $env:ZEPTO_API_TOKEN
}
if ([string]::IsNullOrWhiteSpace($ZeptoToken)) {
    throw 'ZEPTO_API_TOKEN is not configured as an environment variable.'
}

$FromAddress = [Environment]::GetEnvironmentVariable('PROJECT_NOTIFIER_FROM', 'Machine')
if ([string]::IsNullOrWhiteSpace($FromAddress)) { $FromAddress = 'notificacoes.projetos@redesupermarket.com.br' }

$Recipients = @($Para | ForEach-Object {
    @{ email_address = @{ address = $_ } }
})
$Payload = @{
    from = @{ address = $FromAddress; name = 'Notificacoes de Projetos' }
    to = $Recipients
    subject = $Subject
    htmlbody = $HtmlBody
} | ConvertTo-Json -Depth 6

if ($PSCmdlet.ShouldProcess(($Para -join ', '), "Enviar '$Subject'")) {
    $response = Invoke-RestMethod -Method Post -Uri 'https://api.zeptomail.com/v1.1/email' `
        -Headers @{ Authorization = "Zoho-enczapikey $ZeptoToken" } `
        -ContentType 'application/json' -Body $Payload

    $log = [pscustomobject]@{
        timestamp = (Get-Date).ToString('o')
        type = $Tipo
        subject = $Subject
        recipients = $Para
        preview = $PreviewPath
        response = $response
    } | ConvertTo-Json -Depth 8
    Set-Content -Path (Join-Path $LogPath "${Timestamp}-${Tipo}.json") -Value $log -Encoding utf8
    Write-Host 'Email sent and logged.'
}
