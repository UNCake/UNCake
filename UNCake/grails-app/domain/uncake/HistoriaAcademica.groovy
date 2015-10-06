package uncake

class HistoriaAcademica {
    Integer codigo
    Integer cod_plan_estudios
    Integer creditos
    Integer PAPA
    Integer PA
    static hasMany = [materias_aprovadas:Asignatura,
    materias_perdidas:Asignatura,
    materias_canceladas:Asignatura]
    static mappedBy = [materias_aprovadas: "none",
    materias_perdidas: "none",
    materias_canceladas: "none"]
    static constraints = {
    }
}
