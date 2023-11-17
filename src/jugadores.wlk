import equipos.*
import partidos.*

class Jugador{
	const property nombre
	var property edad = 0
	var property peso //kg
	var property altura //cm
	var property posicion
	
	method esEstrella() = posicion.esEstrella(self)
	
	method sumarPartido(){posicion.sumarPartido()}
	
	method habilidad() = posicion.habilidad() //FALTÓ
}


class TipoJugador{
	var property partidosJugados = 0
	method sumarPartido(){partidosJugados++}
	method jugoMasDe(cantPartidos) = partidosJugados > cantPartidos //FALTÓ
}

class Arquero inherits TipoJugador{
	var property golesRecibidos = 0
	var property golesHechos = 0
	
	method esEstrella(jugador) =
		jugador.altura() > 190 or (self.jugoMasDe(100) and self.promedioGolesRecibidos() < 0.8)
	
	method promedioGolesRecibidos() = golesRecibidos / partidosJugados

	method habilidad() = 
		partidosJugados*2 + golesHechos*500 - golesRecibidos
}
 
class Defensor inherits TipoJugador{
	var property amarillas = 0
	var property rojas = 0
	var property golesHechos = 0
		 	
	method esEstrella(jugador) = 
		self.jugoMasDe(150) and jugador.promedioAmarillas() < 0.5 and rojas >= 5

	method habilidad() = 
		partidosJugados*3 + golesHechos*5 - amarillas - rojas*10 
		
	method promedioAmarillas() = amarillas / partidosJugados
	
}

class Mediocampista inherits TipoJugador{
	var property golesHechos = 0
	var property asistencias = 0
	
	method esEstrella(jugador)=                   //vvvvFALTÓvvvv
		jugador.nombre().endsWith("inho") or (self.jugoEnSeleccion() and self.jugoMasDe(250) and golesHechos >= 20 and asistencias >= 80)

	method habilidad() = 
		partidosJugados + golesHechos*2 + asistencias*3 + self.bonusPorSeleccion()
	
	method jugoEnSeleccion() = partidosJugados > 0
	
	method bonusPorSeleccion(){
		if(self.jugoEnSeleccion()) return 100
		return 0
	}
}
//ANTES ERA UN CLASS, PERO NO HACE FALTA INSTANCIARLO
object delantero inherits TipoJugador{
	method esEstrella(jugador) = true
	method habilidad() = 1500
}