object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method bultos() = 1
	method accidentar() {}
}
object arenaAGranel {
	var peso = 0
	method peso(_peso) {
		peso = _peso
	}
	method peso() { return peso }
	method nivelPeligrosidad() {return 1}
	method bultos() = 1
	method accidentar() { peso = peso + 20}
}

object bumblebee {
	var modo = auto
	method modo(transformacion) {
		modo = transformacion
	}
	method modo() {
	  return modo
	}
	method peso() { return 800 }
	method nivelPeligrosidad() { return modo.nivelPeligrosidad() }
	method bultos() = 2
	method accidentar() { modo = modo.transformarse() }
}

object paqueteDeLadrillos {
	const pesoDelLadrillo = 2
	var cantidadDeLadrillos = 0

	method cantidadDeLadrillos(cantidad) {
		cantidadDeLadrillos = cantidad
	}
	method cantidadDeLadrillos() = cantidadDeLadrillos
	method peso() {return cantidadDeLadrillos * pesoDelLadrillo }
	method nivelPeligrosidad() { return 2 }
	
	method bultos() {
    	if (cantidadDeLadrillos <= 100) {
        	return 1
    	} else if (cantidadDeLadrillos.between(101, 300)) {
        	return 2
    	} else {
        	return 3
    	}
	}
	method accidentar() {
		cantidadDeLadrillos = 0.max(cantidadDeLadrillos - 12)
	}
}

object bateriaAntiaerea {
	var tieneMisiles = true

	method tieneMisiles(booleano) {
		tieneMisiles = booleano
	}
	method tieneMisiles() = tieneMisiles
	method peso() { return if (tieneMisiles) 300 else 200 }
	method nivelPeligrosidad() { return if (tieneMisiles) 100 else 0 }
	method bultos() { return if (tieneMisiles) 2 else 1}
	method accidentar() { tieneMisiles = false }
}

object residuosRadiactivos {
	var peso = 0
	
	method peso(_peso) {
		peso = _peso
	}
	method peso() = peso
	method nivelPeligrosidad() { return 200 }
	method bultos() = 1
	method accidentar() {
		peso = peso + 15
	}
}


object contenedorPortuario {
	const cargaDelContenedor = #{}

	method agregarCosa(cosa) {
		cargaDelContenedor.add(cosa)
	}

	method peso() {
		return 100 + self.sumatoriaDeLaCarga()
	}
	method sumatoriaDeLaCarga() {
		return cargaDelContenedor.sum({c => c.peso()})
	}
	method nivelPeligrosidad() {
		return if (not cargaDelContenedor.isEmpty()) self.cosaConMayorNivelPeligrosidad().nivelPeligrosidad() else 0
	}
	method cosaConMayorNivelPeligrosidad() {
		return cargaDelContenedor.max({c => c.nivelPeligrosidad()})
	}
	method bultos() {
		return 1 + cargaDelContenedor.sum({ cosa => cosa.bultos() })
	}
	method accidentar() { cargaDelContenedor.forEach({c => c.accidentar()})}
}

object embalajeDeSeguridad {
	var objetoEnvuelto = knightRider 

	method envolver(unaCosa) {
		objetoEnvuelto = unaCosa
	}
	method peso() {
		return objetoEnvuelto.peso()
	}
	method nivelPeligrosidad() {
		return objetoEnvuelto.nivelPeligrosidad() / 2
	}
	method bultos() = 2
	method accidentar() {}
}


object auto { 
	method nivelPeligrosidad() = 15 
	method transformarse() { return robot }
}
	
object robot { 
	method nivelPeligrosidad() = 30 
	method transformarse() { return auto }

}