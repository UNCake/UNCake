package uncake

import grails.converters.JSON

class BuildingController {

    def index() { }

    def getAllNames(){
        def buildings = Building.createCriteria().list([max: params.maxRows]) {
            and{
                ilike('name', "%${params.name_startsWith}%")
            }
        }
        render buildings.name as JSON
    }

    def getItemByName(){
        def selectedBuilding = Building.createCriteria().list() {
            and{
                ilike('name', "%${params.selectedName}%")
            }
        }
        println "${params.selectedName}"
        println selectedBuilding
        render selectedBuilding.coordinates as JSON

    }

    def insertBogotaBuildings(){
        new Building(code: '101', name: '101 - Torre de Enfermería ', coordinates: '4.635181486487435&-74.08243864774704').save(flush: true)
        new Building(code: '102', name: '102 - Biblioteca Central Gabriel García Márquez', coordinates: '4.63540605513496&-74.08303678035736').save(flush: true)
        new Building(code: '104', name: '104 - Auditorio León de Greiff', coordinates: '4.6357776626211376&-74.08204972743988').save(flush: true)
        new Building(code: '201', name: '201 - Facultad de Derecho, Ciencias Políticas y Sociales', coordinates: '4.635432789493002&-74.08373147249222').save(flush: true)
        new Building(code: '207', name: '207 - Museo de Arquitectura Leopoldo Rother', coordinates: '4.633994479593661&-74.08330231904984').save(flush: true)
        new Building(code: '210', name: '210 - Facultad de Odontología', coordinates: '4.634569269216847&-74.08508062362671').save(flush: true)
        new Building(code: '212', name: '212 - Aulas de Ciencias Humanas', coordinates: '4.634133498522123&-74.08462196588516').save(flush: true)
        new Building(code: '214', name: '214 - Edificio Antonio Nariño - Departamento de Lingüística. Departamento de Ingeniería Civil y Agrícola', coordinates: '4.633366220633711&-74.08419013023376').save(flush: true)
        new Building(code: '217', name: '217 - Edificio Francisco de Paula Santander: Diseño Gráfico', coordinates: '4.633425036389818&-74.08334791660309').save(flush: true)
        new Building(code: '224', name: '224 - Edificio Manuel Ancízar', coordinates: '4.633810012127156&-74.08549904823303').save(flush: true)
        new Building(code: '225', name: '225 - Edificio Rogelio Salmona de Postgrados en Ciencias Humanas', coordinates: '4.633863480962982&-74.0863573551178').save(flush: true)
        new Building(code: '229', name: '229 - Departamento de lenguas extranjeras', coordinates: '4.632911735080601&-74.08435106277466').save(flush: true)
        new Building(code: '231', name: '231 - Departamento de Lenguas Extranjeras', coordinates: '4.632911735080601&-74.08435106277466').save(flush: true)
        new Building(code: '238', name: '238 - Postgrados de Ciencias Económicas', coordinates: '4.632655084286245&-74.083331823349').save(flush: true)
        new Building(code: '239', name: '239 - Filosofía', coordinates: '4.6323342706623&-74.0833854675293').save(flush: true)
        new Building(code: '251', name: '251 - Capilla', coordinates: '4.632911735080601&-74.08149719238281').save(flush: true)
        new Building(code: '301', name: '301 - Escuela de Artes Plásticas', coordinates: '4.636312349308707&-74.08218383789062').save(flush: true)
        new Building(code: '303', name: '303 - Escuela de Arquitectura ', coordinates: '4.636499489553765&-74.08168494701385').save(flush: true)
        new Building(code: '305', name: '305 - Conservatorio de Música', coordinates: '4.635438136364494&-74.08121287822723').save(flush: true)
        new Building(code: '309', name: '309 - Talleres y Aulas de Construcción', coordinates: '4.636344430497097&-74.08054232597351').save(flush: true)
        new Building(code: '310', name: '310 - Facultad de Ciencias Económicas', coordinates: '4.63697536023932&-74.08064693212509').save(flush: true)
        new Building(code: '311', name: '311 - Bloque II Facultad de Ciencias Económicas', coordinates: '4.636697323473209&-74.08050745725632').save(flush: true)
        new Building(code: '314', name: '314 - Postgrados en Arquitectura - SINDU', coordinates: '4.635627950276118&-74.08066034317017').save(flush: true)
        new Building(code: '317', name: '317 - Museo de Arte', coordinates: '4.634769777114958&-74.08086955547333').save(flush: true)
        new Building(code: '401', name: '401 - Facultad de Ingeniería', coordinates: '4.637306865471269&-74.08276587724686').save(flush: true)
        new Building(code: '404', name: '404 - Departamentos de Matemáticas, Física y Estadística', coordinates: '4.637539453726626&-74.08265858888626').save(flush: true)
        new Building(code: '405', name: '405 - Postgrados en Matemáticas y Física', coordinates: '4.637932447501303&-74.08174395561218').save(flush: true)
        new Building(code: '406', name: '406 - Instituto de Extensión e Investigación', coordinates: '4.638162362125235&-74.0827739238739').save(flush: true)
        new Building(code: '407', name: '407 - Postgrados en Materiales y Procesos de Manufactura', coordinates: '4.639274506226086&-74.08207654953003').save(flush: true)
        new Building(code: '408', name: '408 - Laboratorio de Ensayos Hidráulicos', coordinates: '4.638044731396759&-74.08138453960419').save(flush: true)
        new Building(code: '409', name: '409 - Laboratorio de Hidráulica', coordinates: '4.638632884843214&-74.08182442188263').save(flush: true)
        new Building(code: '411', name: '411 - Laboratorios de Ingeniería', coordinates: '4.639221037799788&-74.0824681520462').save(flush: true)
        new Building(code: '412', name: '412 - Laboratorio de Ingeniería Química', coordinates: '4.638555355553295&-74.08310920000076').save(flush: true)
        new Building(code: '413', name: '413 - Observatorio Astronómico', coordinates: '4.6397931497511244&-74.08331036567688').save(flush: true)
        new Building(code: '421', name: '421 - Departamento de Biología', coordinates: '4.640418729578472&-74.0818727016449').save(flush: true)
        new Building(code: '425', name: '425 - Instituto de Ciencias Naturales', coordinates: '4.642364974384453&-74.08190488815308').save(flush: true)
        new Building(code: '426', name: '426 - Instituto de Genética', coordinates: '4.642717864351315&-74.08303141593933').save(flush: true)
        new Building(code: '431', name: '431 - Instituto Pedagógico Arturo Ramírez Montúfar : IPARM', coordinates: '4.640477544747398&-74.08318161964417').save(flush: true)
        new Building(code: '433', name: '433 - Almacén e Imprenta', coordinates: '4.6407074585425665&-74.08362150192261').save(flush: true)
        new Building(code: '434', name: '434 - Instituto Pedagógico Arturo Ramírez Montúfar IPARM', coordinates: '4.640477544747398&-74.08318161964417').save(flush: true)
        new Building(code: '435', name: '435 - Talleres de Mantenimiento', coordinates: '4.640907964698165&-74.08362418413162').save(flush: true)
        new Building(code: '437', name: '437 - Centro de Acopio de Residuos Sólidos', coordinates: '4.64133303755961&-74.08401846885681').save(flush: true)
        new Building(code: '438', name: '438 - Talleres y Gestiones de Mantenimiento', coordinates: '4.641931881911154&-74.08364832401276').save(flush: true)
        new Building(code: '450', name: '450 - Departamento de Farmacia', coordinates: '4.637424496322641&-74.08390581607819').save(flush: true)
        new Building(code: '451', name: '451 - Departamento de Química', coordinates: '4.637830857294799&-74.08357322216034').save(flush: true)
        new Building(code: '452', name: '452 - Postgrados en Bioquímica y Carbones', coordinates: '4.637408455753152&-74.08435642719269').save(flush: true)
        new Building(code: '453', name: '453 - Aulas de Ingeniería', coordinates: '4.638277319409135&-74.08374488353729').save(flush: true)
        new Building(code: '454', name: '454 - Ciencia y Tecnología (CyT)', coordinates: '4.638001956581553&-74.0846836566925').save(flush: true)
        new Building(code: '471', name: '471 - Facultad de Medicina', coordinates: '4.636499489553765&-74.08475339412689').save(flush: true)
        new Building(code: '476', name: '476 - Facultad de Ciencias', coordinates: '4.6372961717565415&-74.08560633659363').save(flush: true)
        new Building(code: '477', name: '477 - Aulas de Informática', coordinates: '4.636900504197671&-74.08532202243805').save(flush: true)
        new Building(code: '480', name: '480 - Depósitos Facultad de Medicina    ', coordinates: '4.636585039363575&-74.08523619174957').save(flush: true)
        new Building(code: '481', name: '481 - Facultad de Medicina Veterinaria y Zootecnia  ', coordinates: '4.636010251379964&-74.08543467521667').save(flush: true)
        new Building(code: '500', name: '500 - Facultad de Ciencias Agrarias    ', coordinates: '4.635638644016098&-74.08716201782227').save(flush: true)
        new Building(code: '500A', name: '500A - Planta de Leches y Vegetales   ', coordinates: '4.636012924813522&-74.08775210380554').save(flush: true)
        new Building(code: '500B', name: '500B - Planta de Carnes     ', coordinates: '4.635242975528976&-74.08863186836243').save(flush: true)
        new Building(code: '500C', name: '500C - Laboratorio de Control de Calidad   ', coordinates: '4.635574481573773&-74.08777356147766').save(flush: true)
        new Building(code: '500D', name: '500D - Supermercado y Aulas     ', coordinates: '4.635467544156972&-74.088374376297').save(flush: true)
        new Building(code: '500F', name: '500F - Invernadero de control     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500G', name: '500G - Caseta de servicios     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500H', name: '500H - Invernadero de Programación     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500I', name: '500I - Invernadero de Crecimiento     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500J', name: '500J - Invernadero de Crecimiento     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500K', name: '500K - Invernadero de Crecimiento     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500L', name: '500L - Centro de Compostaje     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500M', name: '500M - Invernadero de Crecimiento´     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500N', name: '500N - Invernadero de Crecimiento     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500O', name: '500O - Invernadero de Crecimiento     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500P', name: '500P - Invernadero de Crecimiento     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '501', name: '501 - Cirugía y Clínica de Grandes Animales  ', coordinates: '4.636085107515935&-74.08579677343369').save(flush: true)
        new Building(code: '502', name: '502 - Aula y Laboratorios de Histopatología e Inseminación ', coordinates: '4.635809743833814&-74.08571630716324').save(flush: true)
        new Building(code: '503', name: '503 - Auditorios, Anfiteatros y Microbiología    ', coordinates: '4.634991672455892&-74.0854561328888').save(flush: true)
        new Building(code: '504', name: '504 - Patología Aviar, Gallinero y Perrera   ', coordinates: '4.635200200544118&-74.08570289611816').save(flush: true)
        new Building(code: '505', name: '505 - Laboratorio de Inseminación y Corral de Equinos ', coordinates: '4.635563787832826&-74.08594965934753').save(flush: true)
        new Building(code: '506', name: '506 - Laboratorio de Patología Clínica y Corral de Bovinos', coordinates: '4.636114515281467&-74.08628761768341').save(flush: true)
        new Building(code: '507', name: '507 - Clínica de Pequeños Animales    ', coordinates: '4.636638507989421&-74.08626079559326').save(flush: true)
        new Building(code: '508', name: '508 - Oficinas       ', coordinates: '4.636424633461698&-74.0861052274704').save(flush: true)
        new Building(code: '510', name: '510 - Farmacia y Oficinas     ', coordinates: '4.635836478176577&-74.08620178699493').save(flush: true)
        new Building(code: '531', name: '531 - Laboratorio de Investigaciones Patológicas    ', coordinates: '4.634943550580651&-74.08649682998657').save(flush: true)
        new Building(code: '532', name: '532 - Laboratorio de Investigaciones Patológicas    ', coordinates: '4.634943550580651&-74.08649682998657').save(flush: true)
        new Building(code: '533', name: '533 - Laboratorio de Investigaciones Patológicas    ', coordinates: '4.634751063046875&-74.08729076385498').save(flush: true)
        new Building(code: '534', name: '534 - Laboratorio de Investigaciones Patológicas    ', coordinates: '4.634355394062823&-74.08706545829773').save(flush: true)
        new Building(code: '535', name: '535 - Laboratorio de Investigaciones Patológicas    ', coordinates: '4.634355394062823&-74.08706545829773').save(flush: true)
        new Building(code: '537', name: '537 - Laboratorio de Investigaciones Patológicas    ', coordinates: '4.634312619024253&-74.0882670879364').save(flush: true)
        new Building(code: '561', name: '561 - Posgrados de Veterinaria     ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561A', name: '561A - Oficinas de Producción Animal    ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561B', name: '561B - Posgrado Reproducción Animal     ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561C', name: '561C - Bioterio y Establos de Producción   ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561D', name: '561D - Comportamiento Anima      ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561E', name: '561E - Investigaciones Avícolas      ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561F', name: '561F - Bioterio de Experimentación     ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561G', name: '561G - Unibiblos       ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561H', name: '561H - Aulas y depósitos Unibiblos    ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561I', name: '561I - Horno Crematorio      ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '571', name: '571 - Hemeroteca Nacional      ', coordinates: '4.63651553014389&-74.09124970436096').save(flush: true)
        new Building(code: '606', name: '606 - Instituto Interamericano de Cooperación para la Agricultura ', coordinates: '4.636451367781192&-74.07987713813782').save(flush: true)
        new Building(code: '608', name: '608 - Unidad de Servicios de Computación y SIA ', coordinates: '4.637392415183295&-74.07995223999023').save(flush: true)
        new Building(code: '610', name: '610 - Centro en Investigación y Desarrollo en Información Geográfica', coordinates: '4.637825510441411&-74.08011853694916').save(flush: true)
        new Building(code: '701', name: '701 - Departamento de Cine y Televisión   ', coordinates: '4.640306446060535&-74.08568143844604').save(flush: true)
        new Building(code: '710', name: '710 - Diamante de Béisbol     ', coordinates: '4.6410068810472715&-74.08533811569214').save(flush: true)
        new Building(code: '731', name: '731 - Estadio de fútbol Alfonso López Pumarejo    ', coordinates: '4.6403759549070775&-74.0862500667572').save(flush: true)
        new Building(code: '761', name: '761 - Concha Acústica      ', coordinates: '4.638632884843214&-74.08722639083862').save(flush: true)
        new Building(code: '861', name: '861 - Edificio Uriel Gutiérrez     ', coordinates: '4.639600663538869&-74.08976376056671').save(flush: true)
        new Building(code: '862', name: '862 - Unidad Camilo Torres     ', coordinates: '4.640814395165972&-74.09076690673828').save(flush: true)
        new Building(code: '910', name: '910 - Instituto Colombiano de Normas Técnicas y Certificación: Icontec', coordinates: '4.64431121382209&-74.08361077308655').save(flush: true)
        new Building(code: '935', name: '935 - Sede Sector CAN     ', coordinates: '4.648011192666337&-74.09578800201416').save(flush: true)
    }

}
