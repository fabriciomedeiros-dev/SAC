import React from 'react';
import BrowserOnly from '@docusaurus/BrowserOnly';
import useBaseUrl from '@docusaurus/useBaseUrl';
import styles from './styles.module.css';

/**
 * Renderiza um arquivo .bpmn com o visualizador do bpmn.io (bpmn-js).
 *
 * Uso em um documento .mdx:
 *   <BpmnViewer src="/bpmn/ciclo-de-vida-do-chamado.bpmn" title="Ciclo de vida do chamado" />
 *
 * O arquivo .bpmn precisa estar em `static/`, para ser servido como asset.
 * bpmn-js depende do DOM, então a renderização acontece só no navegador.
 */
export default function BpmnViewer({src, title = 'Diagrama BPMN', height = 640}) {
  const url = useBaseUrl(src);

  return (
    <BrowserOnly
      fallback={
        <div className={styles.fallback} style={{height}}>
          Carregando diagrama…
        </div>
      }>
      {() => {
        const Canvas = require('./BpmnCanvas').default;
        return <Canvas url={url} title={title} height={height} />;
      }}
    </BrowserOnly>
  );
}
