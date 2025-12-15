import { useEffect, useState } from 'react';

const HealthCheck = () => {
  const [status, setStatus] = useState<string>('⏳ Comprobando conexión con el servidor...');
  const [isError, setIsError] = useState<boolean>(false);

  useEffect(() => {
    fetch('/api/health')
      .then(res => {
        if (!res.ok) throw new Error(`HTTP error! status: ${res.status}`);
        return res.json();
      })
      .then(data => {
        setStatus(`✅ Backend Conectado: ${data.message}`);
        setIsError(false);
      })
      .catch(err => {
        console.error('Error de conexión:', err);
        setStatus(`❌ Error de conexión: ${err.message}. Asegúrate de que el backend esté corriendo en el puerto 3000.`);
        setIsError(true);
      });
  }, []);

  return (
    <div style={{ 
      padding: '1rem', 
      backgroundColor: isError ? '#ffebee' : '#e8f5e9', 
      color: isError ? '#c62828' : '#2e7d32',
      border: `1px solid ${isError ? '#ef9a9a' : '#a5d6a7'}`,
      borderRadius: '8px',
      margin: '1rem 0',
      fontFamily: 'monospace'
    }}>
      <strong>Estado del Sistema:</strong> {status}
    </div>
  );
};

export default HealthCheck;
