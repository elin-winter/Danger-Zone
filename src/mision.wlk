class Mision {
  const habilidadesReqs
  const peligrosidad

  method habilidadesReqs() = habilidadesReqs

  method realizarMision(grupo) { 
    if(grupo.puedeRealizar(self)) {
      grupo.sufrirEfectos(peligrosidad)
      
      const sobrevivientes = grupo.sobrevivieron()

      if(sobrevivientes.isEmpty()) 
        throw new DomainException (message = "Ninguno sobrevivió :( , no puedo aplicar efectos de mision")
      else 
        sobrevivientes.registrarMision(self)
    }
  }
}