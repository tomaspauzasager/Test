 import jugadores.*
 import partidos.*

class Equipo{
	const integrantes = #{} //Máximo 11
	const limiteEstrellas 
	var victorias = 0
	var derrotas = 0
	var empates = 0
	
	method agregarJugador(jugador){  //USAR THROW ENVES DE SEL.ERROR
		if(not(self.equipoCompleto())) throw new Exception(message = "El equipo ya esta lleno")
		
		if(jugador.esEstrella()){
			if(self.cantEstrellas() < limiteEstrellas) 
				integrantes.add(jugador)
			
			else throw new Exception(message = "No se admiten más estrellas")
		}
		else integrantes.add(jugador)
	}

	
	method equipoCompleto() = integrantes.size() == 11

	method cantEstrellas(){ 
		const estrellas = integrantes.filter({integrante => integrante.esEstrella()})
		return estrellas.size()
	}
	
	method tieneMejorEquipoQue(equipo){
		return self.sumaHabilidades() > equipo.sumaHabilidades()
	}
	
	method sumaHabilidades() = 
		integrantes.sum({integrante => integrante.habilidad()})

	method ganar(){
		victorias++
		self.sumarPartido()
	}
	method perder(){
		derrotas++
		self.sumarPartido()
	}
	method empatar(){
		empates++
		self.sumarPartido()
	}
	
	method sumarPartido(){integrantes.forEach({jugador => jugador.sumarPartido()})}
	
	method puntaje() = victorias*3 + empates
	
	method integrante(nombre) = integrantes.any({integrante => integrante.nombre() == nombre})
}

class Pro inherits Equipo(limiteEstrellas = 9){
	method cumplioObjetivo(){
		if(self.integrante("Messi")) return self.puntaje() >= 18
		else return self.puntaje() >= 12
	}
}

class MedioPelo inherits Equipo(limiteEstrellas = 3){
	method cumplioObjetivo() = self.puntaje() >= self.cantEstrellas()
}

object brasil inherits Equipo(limiteEstrellas = 1000000){
	method cumplioObjetivo() = self.puntaje() == 21
}