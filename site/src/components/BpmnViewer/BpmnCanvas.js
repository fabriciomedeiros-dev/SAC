import React, {useCallback, useEffect, useRef, useState} from 'react';
import NavigatedViewer from 'bpmn-js/lib/NavigatedViewer';

import 'bpmn-js/dist/assets/diagram-js.css';
import 'bpmn-js/dist/assets/bpmn-js.css';
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn-embedded.css';

import styles from './styles.module.css';

// Só é carregado no navegador (via BrowserOnly em ./index.js) — bpmn-js precisa do DOM.
export default function BpmnCanvas({url, title, height}) {
  const wrapperRef = useRef(null);
  const containerRef = useRef(null);
  const viewerRef = useRef(null);

  const [status, setStatus] = useState('loading');
  const [error, setError] = useState(null);

  useEffect(() => {
    const viewer = new NavigatedViewer({container: containerRef.current});
    viewerRef.current = viewer;

    let cancelled = false;

    (async () => {
      try {
        const response = await fetch(url);
        if (!response.ok) {
          throw new Error(`HTTP ${response.status} ao buscar ${url}`);
        }
        const xml = await response.text();
        if (cancelled) return;

        await viewer.importXML(xml);
        viewer.get('canvas').zoom('fit-viewport', 'auto');
        setStatus('ready');
      } catch (err) {
        if (cancelled) return;
        setError(err.message);
        setStatus('error');
      }
    })();

    return () => {
      cancelled = true;
      viewer.destroy();
      viewerRef.current = null;
    };
  }, [url]);

  const fit = useCallback(() => {
    viewerRef.current?.get('canvas').zoom('fit-viewport', 'auto');
  }, []);

  const zoomBy = useCallback((step) => {
    const canvas = viewerRef.current?.get('canvas');
    if (!canvas) return;
    canvas.zoom(Math.min(Math.max(canvas.zoom() + step, 0.2), 4));
  }, []);

  const toggleFullscreen = useCallback(() => {
    if (document.fullscreenElement) {
      document.exitFullscreen();
    } else {
      wrapperRef.current?.requestFullscreen?.();
    }
  }, []);

  // Reenquadra ao entrar/sair de tela cheia, quando o container muda de tamanho.
  useEffect(() => {
    const onChange = () => window.setTimeout(fit, 100);
    document.addEventListener('fullscreenchange', onChange);
    return () => document.removeEventListener('fullscreenchange', onChange);
  }, [fit]);

  return (
    <figure className={styles.wrapper} ref={wrapperRef}>
      <div className={styles.toolbar}>
        <span className={styles.title}>{title}</span>
        <div className={styles.actions}>
          <button type="button" onClick={() => zoomBy(0.2)} title="Aproximar">
            +
          </button>
          <button type="button" onClick={() => zoomBy(-0.2)} title="Afastar">
            −
          </button>
          <button type="button" onClick={fit} title="Ajustar à tela">
            Ajustar
          </button>
          <button type="button" onClick={toggleFullscreen} title="Tela cheia">
            Tela cheia
          </button>
          <a href={url} download title="Baixar o arquivo .bpmn">
            Baixar .bpmn
          </a>
        </div>
      </div>

      <div className={styles.canvas} style={{height}} ref={containerRef} />

      {status === 'loading' && <div className={styles.overlay}>Carregando diagrama…</div>}
      {status === 'error' && (
        <div className={styles.overlay}>Não foi possível carregar o diagrama: {error}</div>
      )}

      <figcaption className={styles.hint}>
        Arraste para mover · <kbd>Ctrl</kbd> + scroll para dar zoom
      </figcaption>
    </figure>
  );
}
