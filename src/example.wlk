// ----------------------------- Empleado

class Empleado {

  // ---------- Referencias

  const habilidades
  var cantSalud
  const subordinados
  var tipoEmpleado

  // ---------- Metodos

  // Accesors
  
  method tipoEmpleado(nuevoTipo) {
    tipoEmpleado = nuevoTipo
  }

  method habilidades() = habilidades

  // Controles

  method esJefe() = !subordinados.isEmpty()

  method estaIncapacitado() = cantSalud < tipoEmpleado.saludCritica()

  method puedeUsar(habilidad) = 
    !self.estaIncapacitado() and self.poseeHabilidad(habilidad)

  method poseeHabilidad(habilidad) = 
    habilidades.contains(habilidad) or subordinados.any({x => x.poseeHabilidad(habilidad)})

  method puedeRealizar(mision) = 
    mision.habilidadesReqs().forEach({x => self.puedeUsar(x)})
  
  method sobrevivieron() = 
    if(cantSalud > 0) self
    else []

  // Acciones

  method sufrirEfectos(cant) {
    cantSalud -= cant
  }

  method registrarMision(mision) = tipoEmpleado.misionTerminada(mision, self)
}

// -------- Tipos de Empleados


object espia {
  
  method saludCritica() = 15

  method misionTerminada(mision, empleado) {
    mision.habilidadesReqs().forEach({h => self.aprenderHabilidad(h, empleado)})
  }

  method aprenderHabilidad(nuevaHabilidad, empleado) {
    if(!empleado.habilidades().contains(nuevaHabilidad))
    empleado.habilidades().add(nuevaHabilidad)
  }
}

object oficinista {
  var cantEstrellas = 0
  const saludCriticaBase = 40

  method saludCritica() = saludCriticaBase - 5 * cantEstrellas

  method misionTerminada(_,empleado) {
    cantEstrellas += 1
    if(cantEstrellas > 3) empleado.tipoEmpleado(espia)
  }
}


// ----------------------------- Grupo de Empleados para Misiones

class GrupoEmpleados {
  const miembros

  method puedeRealizar(mision) = 
    mision.habilidadesReqs().forEach({h => self.algunMiembroUsa(h)})
  
  method algunMiembroUsa(habilidad) = 
    miembros.any({ m => m.puedeUsar(habilidad)})
  
  method sufrirEfectos(cant) {
    miembros.forEach({m => m.sufrirEfectos(cant * 0.3)})
  }

  method sobrevivieron() = 
    miembros.filter({m => m.sobrevivieron()})

}