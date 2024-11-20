object agenciaISIS {

  method realizarMision(grupo, mision) { 
    if(grupo.puedeRealizar(mision)) {
      grupo.sufrirEfectos(mision.peligrosidad())
      
      const sobrevivientes = grupo.sobrevivieron()

      if(sobrevivientes.isEmpty()) 
        throw new DomainException (message = "Ninguno sobrevivió :( , no puedo aplicar efectos de mision")
      else 
        sobrevivientes.registrarMision(mision)
    }
  }
}