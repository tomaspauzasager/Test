 import jugadores.*
 import equipos.*

class Partido{
	const property local
	const property visitante
	const adicionalPorLocal = 1
	
	method determinarGanador(){
		if(local.equipoCompleto() and visitante.equipoCompleto())
			throw new Exception(message = "uno de los equipos no esta completo")
		
		const puntajeLocal = self.puntajeEquipo(local, visitante) + adicionalPorLocal
		const puntajeVisitante = self.puntajeEquipo(visitante, local)
		
		if(puntajeLocal == puntajeVisitante){
			local.empatar()
			visitante.empatar()
			return "EMPATE"
		}
		if(puntajeLocal > puntajeVisitante){
			local.ganar()
			visitante.perder()
			return local
		}
		else {
			visitante.ganar()
			local.perder()
			return visitante
		}
	}
	
	method puntajeEquipo(equipo, otroEquipo){
		var puntaje = equipo.cantEstrellas()
		if(equipo.tieneMejorEquipoQue(otroEquipo))
			puntaje += 5
		
		return puntaje
	}
}

object mundial{
	const property partidos = []
	const property equipos = #{}
	
	method hubaBatacazo() = 
		equipos.any({equipo => equipo.cantEstrellas() < 2 and equipo.puntaje() >= 1})
	
	method estamosBien() = equipos.forAll({equipo => equipo.cumplioObjetivo()})
}
