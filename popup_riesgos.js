// Copilot: genera popups desde riesgos_activos.json
// muestra nivel, título, descripción y botones sugeridos
fetch('riesgos_activos.json')
  .then(res => res.json())
  .then(data => {
    data.riesgos.forEach(riesgo => {
      const div = document.createElement('div');
      div.className = 'popup-riesgo ' + riesgo.nivel.toLowerCase();
      div.innerHTML = `
        <h3>${riesgo.titulo}</h3>
        <p><strong>${riesgo.nivel}</strong> - ${riesgo.descripcion}</p>
        <em>${riesgo.recomendacion}</em>
      `;
      document.body.appendChild(div);
    });
  });
