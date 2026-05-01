import cosas.*

object camion {
	const property carga = #{}
	const camionVacio = 1000
	const pesoMaximoAceptable = 2500

	method cargar(unaCosa) {
        if(carga.contains(unaCosa)) {
            self.error("La cosa ya esta cargada en el camion")
        }
        carga.add(unaCosa) 
    }

	method descargar(unaCosa) {
		if(carga.contains(unaCosa)) {
			carga.remove(unaCosa)
		} else {
			self.error("No se puede descargar algo que no esta en el camion")
		}
	}
	method todoPesoEsPar() {
		return carga.all({c => c.peso().even()})
	}
	method hayAlgunoQuePesa(peso) {
		return carga.any({c => c.peso() == peso})
	}

	method pesoTotal() {
		return camionVacio + self.pesoDeLaCarga()
	}
	method pesoDeLaCarga() {
		return carga.sum({cosa => cosa.peso()})
	}

	method excedidoDePeso() {
		return self.pesoTotal() > pesoMaximoAceptable
	}

	method cosaDeNivel(nivelDePeligrosidad) {
		return carga.find({c => c.nivelPeligrosidad() == nivelDePeligrosidad })
	}

	method cosasQueSuperanPeligrosidad(nivelDePeligrosidad) {
		return carga.filter({c => c.nivelPeligrosidad() > nivelDePeligrosidad})
	}

	method cosasPeligrosasMasQue(unaCosa) {
		return self.cosasQueSuperanPeligrosidad(unaCosa.nivelPeligrosidad())
	}

	method puedeCircularEnRuta(maximoPeligrosidad) {
		return not self.excedidoDePeso() and carga.all({c => c.nivelPeligrosidad() <= maximoPeligrosidad})
	}

	method tieneAlgoQuePesaEntre(minimo, maximo) {
		return carga.any({ cosa => cosa.peso().between(minimo, maximo) })
	}

	method cosaMasPesada() {
        return carga.max({ cosa => cosa.peso() })
    }

	method pesos() {
		return carga.map({cosa => cosa.peso()})
	}

	method totalBultos() {
		return carga.sum({cosa => cosa.bultos()})
	}

	method sufreAccidente() {
		 carga.forEach({c => c.accidentar()})
	}

	method transportar(destino, camino) {
        if (not camino.soporta(self)) {
            self.error("El viaje no puede ser realizado por este camino")
        }
        destino.recibirCarga(carga)
        carga.clear()
    }

	
}


object almacen {
	const inventario = #{}

    method recibirCarga(carga) {
        inventario.addAll(carga)
    }
    method cosasGuardadas() {
        return inventario
    }
}

object ruta9 {
	method soporta(vehiculo) {
        return vehiculo.puedeCircularEnRuta(20)
    }
}

object caminosVecinales {
    var pesoMaximoPermitido = 0 

    method pesoMaximoPermitido(peso) {
        pesoMaximoPermitido = peso
    }

    method soporta(vehiculo) {
        return vehiculo.pesoTotal() <= pesoMaximoPermitido
    }
}