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
        new Building(code: '101', name: '101 - TORRE DE ENFERMERIA ', coordinates: '4.635181486487435&-74.08243864774704').save(flush: true)
        new Building(code: '102', name: '102 - BIBLIOTECA CENTRAL GABRIEL GARCIA MARQUEZ', coordinates: '4.63540605513496&-74.08303678035736').save(flush: true)
        new Building(code: '104', name: '104 - AUDITORIO LEON DE GREIFF', coordinates: '4.6357776626211376&-74.08204972743988').save(flush: true)
        new Building(code: '201', name: '201 - FACULTAD DE DERECHO, CIENCIAS POLITICAS Y SOCIALES', coordinates: '4.635432789493002&-74.08373147249222').save(flush: true)
        new Building(code: '207', name: '207 - MUSEO DE ARQUITECTURA LEOPOLDO ROTHER', coordinates: '4.633994479593661&-74.08330231904984').save(flush: true)
        new Building(code: '210', name: '210 - FACULTAD DE ODONTOLOGIA', coordinates: '4.634569269216847&-74.08508062362671').save(flush: true)
        new Building(code: '212', name: '212 - AULAS DE CIENCIAS HUMANAS', coordinates: '4.634133498522123&-74.08462196588516').save(flush: true)
        new Building(code: '214', name: '214 - EDIFICIO ANTONIO NARINO - DEPARTAMENTO DE LINGUISTICA. DEPARTAMENTO DE INGENIERIA CIVIL Y AGRICOLA', coordinates: '4.633366220633711&-74.08419013023376').save(flush: true)
        new Building(code: '217', name: '217 - EDIFICIO FRANCISCO DE PAULA SANTANDER: DISENO GRAFICO', coordinates: '4.633425036389818&-74.08334791660309').save(flush: true)
        new Building(code: '224', name: '224 - EDIFICIO MANUEL ANCIZAR', coordinates: '4.633810012127156&-74.08549904823303').save(flush: true)
        new Building(code: '225', name: '225 - EDIFICIO ROGELIO SALMONA DE POSTGRADOS EN CIENCIAS HUMANAS', coordinates: '4.633863480962982&-74.0863573551178').save(flush: true)
        new Building(code: '229', name: '229 - DEPARTAMENTO DE LENGUAS EXTRANJERAS', coordinates: '4.632911735080601&-74.08435106277466').save(flush: true)
        new Building(code: '231', name: '231 - DEPARTAMENTO DE LENGUAS EXTRANJERAS', coordinates: '4.632911735080601&-74.08435106277466').save(flush: true)
        new Building(code: '238', name: '238 - POSTGRADOS DE CIENCIAS ECONOMICAS', coordinates: '4.632655084286245&-74.083331823349').save(flush: true)
        new Building(code: '239', name: '239 - FILOSOFIA', coordinates: '4.6323342706623&-74.0833854675293').save(flush: true)
        new Building(code: '251', name: '251 - CAPILLA', coordinates: '4.632911735080601&-74.08149719238281').save(flush: true)
        new Building(code: '301', name: '301 - ESCUELA DE ARTES PLASTICAS', coordinates: '4.636312349308707&-74.08218383789062').save(flush: true)
        new Building(code: '303', name: '303 - ESCUELA DE ARQUITECTURA ', coordinates: '4.636499489553765&-74.08168494701385').save(flush: true)
        new Building(code: '305', name: '305 - CONSERVATORIO DE MUSICA', coordinates: '4.635438136364494&-74.08121287822723').save(flush: true)
        new Building(code: '309', name: '309 - TALLERES Y AULAS DE CONSTRUCCION', coordinates: '4.636344430497097&-74.08054232597351').save(flush: true)
        new Building(code: '310', name: '310 - FACULTAD DE CIENCIAS ECONOMICAS', coordinates: '4.63697536023932&-74.08064693212509').save(flush: true)
        new Building(code: '311', name: '311 - BLOQUE II FACULTAD DE CIENCIAS ECONOMICAS', coordinates: '4.636697323473209&-74.08050745725632').save(flush: true)
        new Building(code: '314', name: '314 - POSTGRADOS EN ARQUITECTURA - SINDU', coordinates: '4.635627950276118&-74.08066034317017').save(flush: true)
        new Building(code: '317', name: '317 - MUSEO DE ARTE', coordinates: '4.634769777114958&-74.08086955547333').save(flush: true)
        new Building(code: '401', name: '401 - FACULTAD DE INGENIERIA', coordinates: '4.637306865471269&-74.08276587724686').save(flush: true)
        new Building(code: '404', name: '404 - DEPARTAMENTOS DE MATEMATICAS, FISICA Y ESTADISTICA', coordinates: '4.637539453726626&-74.08265858888626').save(flush: true)
        new Building(code: '405', name: '405 - POSTGRADOS EN MATEMATICAS Y FISICA', coordinates: '4.637932447501303&-74.08174395561218').save(flush: true)
        new Building(code: '406', name: '406 - INSTITUTO DE EXTENSION E INVESTIGACION', coordinates: '4.638162362125235&-74.0827739238739').save(flush: true)
        new Building(code: '407', name: '407 - POSTGRADOS EN MATERIALES Y PROCESOS DE MANUFACTURA', coordinates: '4.639274506226086&-74.08207654953003').save(flush: true)
        new Building(code: '408', name: '408 - LABORATORIO DE ENSAYOS HIDRAULICOS', coordinates: '4.638044731396759&-74.08138453960419').save(flush: true)
        new Building(code: '409', name: '409 - LABORATORIO DE HIDRAULICA', coordinates: '4.638632884843214&-74.08182442188263').save(flush: true)
        new Building(code: '411', name: '411 - LABORATORIOS DE INGENIERIA', coordinates: '4.639221037799788&-74.0824681520462').save(flush: true)
        new Building(code: '412', name: '412 - LABORATORIO DE INGENIERIA QUIMICA', coordinates: '4.638555355553295&-74.08310920000076').save(flush: true)
        new Building(code: '413', name: '413 - OBSERVATORIO ASTRONOMICO', coordinates: '4.6397931497511244&-74.08331036567688').save(flush: true)
        new Building(code: '421', name: '421 - DEPARTAMENTO DE BIOLOGIA', coordinates: '4.640418729578472&-74.0818727016449').save(flush: true)
        new Building(code: '425', name: '425 - INSTITUTO DE CIENCIAS NATURALES', coordinates: '4.642364974384453&-74.08190488815308').save(flush: true)
        new Building(code: '426', name: '426 - INSTITUTO DE GENETICA', coordinates: '4.642717864351315&-74.08303141593933').save(flush: true)
        new Building(code: '431', name: '431 - INSTITUTO PEDAGOGICO ARTURO RAMIREZ MONTUFAR : IPARM', coordinates: '4.640477544747398&-74.08318161964417').save(flush: true)
        new Building(code: '433', name: '433 - ALMACEN E IMPRENTA', coordinates: '4.6407074585425665&-74.08362150192261').save(flush: true)
        new Building(code: '434', name: '434 - INSTITUTO PEDAGOGICO ARTURO RAMIREZ MONTUFAR IPARM', coordinates: '4.640477544747398&-74.08318161964417').save(flush: true)
        new Building(code: '435', name: '435 - TALLERES DE MANTENIMIENTO', coordinates: '4.640907964698165&-74.08362418413162').save(flush: true)
        new Building(code: '437', name: '437 - CENTRO DE ACOPIO DE RESIDUOS SOLIDOS', coordinates: '4.64133303755961&-74.08401846885681').save(flush: true)
        new Building(code: '438', name: '438 - TALLERES Y GESTIONES DE MANTENIMIENTO', coordinates: '4.641931881911154&-74.08364832401276').save(flush: true)
        new Building(code: '450', name: '450 - DEPARTAMENTO DE FARMACIA', coordinates: '4.637424496322641&-74.08390581607819').save(flush: true)
        new Building(code: '451', name: '451 - DEPARTAMENTO DE QUIMICA', coordinates: '4.637830857294799&-74.08357322216034').save(flush: true)
        new Building(code: '452', name: '452 - POSTGRADOS EN BIOQUIMICA Y CARBONES', coordinates: '4.637408455753152&-74.08435642719269').save(flush: true)
        new Building(code: '453', name: '453 - AULAS DE INGENIERIA', coordinates: '4.638277319409135&-74.08374488353729').save(flush: true)
        new Building(code: '454', name: '454 - CIENCIA Y TECNOLOGIA (CYT)', coordinates: '4.638001956581553&-74.0846836566925').save(flush: true)
        new Building(code: '471', name: '471 - FACULTAD DE MEDICINA', coordinates: '4.636499489553765&-74.08475339412689').save(flush: true)
        new Building(code: '476', name: '476 - FACULTAD DE CIENCIAS', coordinates: '4.6372961717565415&-74.08560633659363').save(flush: true)
        new Building(code: '477', name: '477 - AULAS DE INFORMATICA', coordinates: '4.636900504197671&-74.08532202243805').save(flush: true)
        new Building(code: '480', name: '480 - DEPOSITOS FACULTAD DE MEDICINA    ', coordinates: '4.636585039363575&-74.08523619174957').save(flush: true)
        new Building(code: '481', name: '481 - FACULTAD DE MEDICINA VETERINARIA Y ZOOTECNIA  ', coordinates: '4.636010251379964&-74.08543467521667').save(flush: true)
        new Building(code: '500', name: '500 - FACULTAD DE CIENCIAS AGRARIAS    ', coordinates: '4.635638644016098&-74.08716201782227').save(flush: true)
        new Building(code: '500A', name: '500A - PLANTA DE LECHES Y VEGETALES   ', coordinates: '4.636012924813522&-74.08775210380554').save(flush: true)
        new Building(code: '500B', name: '500B - PLANTA DE CARNES     ', coordinates: '4.635242975528976&-74.08863186836243').save(flush: true)
        new Building(code: '500C', name: '500C - LABORATORIO DE CONTROL DE CALIDAD   ', coordinates: '4.635574481573773&-74.08777356147766').save(flush: true)
        new Building(code: '500D', name: '500D - SUPERMERCADO Y AULAS     ', coordinates: '4.635467544156972&-74.088374376297').save(flush: true)
        new Building(code: '500F', name: '500F - INVERNADERO DE CONTROL     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500G', name: '500G - CASETA DE SERVICIOS     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500H', name: '500H - INVERNADERO DE PROGRAMACION     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500I', name: '500I - INVERNADERO DE CRECIMIENTO     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500J', name: '500J - INVERNADERO DE CRECIMIENTO     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500K', name: '500K - INVERNADERO DE CRECIMIENTO     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500L', name: '500L - CENTRO DE COMPOSTAJE     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500M', name: '500M - INVERNADERO DE CRECIMIENTO´     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500N', name: '500N - INVERNADERO DE CRECIMIENTO     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500O', name: '500O - INVERNADERO DE CRECIMIENTO     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '500P', name: '500P - INVERNADERO DE CRECIMIENTO     ', coordinates: '4.636189371406396&-74.08853530883789').save(flush: true)
        new Building(code: '501', name: '501 - CIRUGIA Y CLINICA DE GRANDES ANIMALES  ', coordinates: '4.636085107515935&-74.08579677343369').save(flush: true)
        new Building(code: '502', name: '502 - AULA Y LABORATORIOS DE HISTOPATOLOGIA E INSEMINACION ', coordinates: '4.635809743833814&-74.08571630716324').save(flush: true)
        new Building(code: '503', name: '503 - AUDITORIOS, ANFITEATROS Y MICROBIOLOGIA    ', coordinates: '4.634991672455892&-74.0854561328888').save(flush: true)
        new Building(code: '504', name: '504 - PATOLOGIA AVIAR, GALLINERO Y PERRERA   ', coordinates: '4.635200200544118&-74.08570289611816').save(flush: true)
        new Building(code: '505', name: '505 - LABORATORIO DE INSEMINACION Y CORRAL DE EQUINOS ', coordinates: '4.635563787832826&-74.08594965934753').save(flush: true)
        new Building(code: '506', name: '506 - LABORATORIO DE PATOLOGIA CLINICA Y CORRAL DE BOVINOS', coordinates: '4.636114515281467&-74.08628761768341').save(flush: true)
        new Building(code: '507', name: '507 - CLINICA DE PEQUENOS ANIMALES    ', coordinates: '4.636638507989421&-74.08626079559326').save(flush: true)
        new Building(code: '508', name: '508 - OFICINAS       ', coordinates: '4.636424633461698&-74.0861052274704').save(flush: true)
        new Building(code: '510', name: '510 - FARMACIA Y OFICINAS     ', coordinates: '4.635836478176577&-74.08620178699493').save(flush: true)
        new Building(code: '531', name: '531 - LABORATORIO DE INVESTIGACIONES PATOLOGICAS    ', coordinates: '4.634943550580651&-74.08649682998657').save(flush: true)
        new Building(code: '532', name: '532 - LABORATORIO DE INVESTIGACIONES PATOLOGICAS    ', coordinates: '4.634943550580651&-74.08649682998657').save(flush: true)
        new Building(code: '533', name: '533 - LABORATORIO DE INVESTIGACIONES PATOLOGICAS    ', coordinates: '4.634751063046875&-74.08729076385498').save(flush: true)
        new Building(code: '534', name: '534 - LABORATORIO DE INVESTIGACIONES PATOLOGICAS    ', coordinates: '4.634355394062823&-74.08706545829773').save(flush: true)
        new Building(code: '535', name: '535 - LABORATORIO DE INVESTIGACIONES PATOLOGICAS    ', coordinates: '4.634355394062823&-74.08706545829773').save(flush: true)
        new Building(code: '537', name: '537 - LABORATORIO DE INVESTIGACIONES PATOLOGICAS    ', coordinates: '4.634312619024253&-74.0882670879364').save(flush: true)
        new Building(code: '561', name: '561 - POSGRADOS DE VETERINARIA     ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561A', name: '561A - OFICINAS DE PRODUCCION ANIMAL    ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561B', name: '561B - POSGRADO REPRODUCCION ANIMAL     ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561C', name: '561C - BIOTERIO Y ESTABLOS DE PRODUCCION   ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561D', name: '561D - COMPORTAMIENTO ANIMA      ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561E', name: '561E - INVESTIGACIONES AVICOLAS      ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561F', name: '561F - BIOTERIO DE EXPERIMENTACION     ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561G', name: '561G - UNIBIBLOS       ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561H', name: '561H - AULAS Y DEPOSITOS UNIBIBLOS    ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '561I', name: '561I - HORNO CREMATORIO      ', coordinates: '4.637322906043073&-74.08755362033844').save(flush: true)
        new Building(code: '571', name: '571 - HEMEROTECA NACIONAL      ', coordinates: '4.63651553014389&-74.09124970436096').save(flush: true)
        new Building(code: '606', name: '606 - INSTITUTO INTERAMERICANO DE COOPERACION PARA LA AGRICULTURA ', coordinates: '4.636451367781192&-74.07987713813782').save(flush: true)
        new Building(code: '608', name: '608 - UNIDAD DE SERVICIOS DE COMPUTACION Y SIA ', coordinates: '4.637392415183295&-74.07995223999023').save(flush: true)
        new Building(code: '610', name: '610 - CENTRO EN INVESTIGACION Y DESARROLLO EN INFORMACION GEOGRAFICA', coordinates: '4.637825510441411&-74.08011853694916').save(flush: true)
        new Building(code: '701', name: '701 - DEPARTAMENTO DE CINE Y TELEVISION   ', coordinates: '4.640306446060535&-74.08568143844604').save(flush: true)
        new Building(code: '710', name: '710 - DIAMANTE DE BEISBOL     ', coordinates: '4.6410068810472715&-74.08533811569214').save(flush: true)
        new Building(code: '731', name: '731 - ESTADIO DE FUTBOL ALFONSO LOPEZ PUMAREJO    ', coordinates: '4.6403759549070775&-74.0862500667572').save(flush: true)
        new Building(code: '761', name: '761 - CONCHA ACUSTICA      ', coordinates: '4.638632884843214&-74.08722639083862').save(flush: true)
        new Building(code: '861', name: '861 - EDIFICIO URIEL GUTIERREZ     ', coordinates: '4.639600663538869&-74.08976376056671').save(flush: true)
        new Building(code: '862', name: '862 - UNIDAD CAMILO TORRES     ', coordinates: '4.640814395165972&-74.09076690673828').save(flush: true)
        new Building(code: '910', name: '910 - INSTITUTO COLOMBIANO DE NORMAS TECNICAS Y CERTIFICACION: ICONTEC', coordinates: '4.64431121382209&-74.08361077308655').save(flush: true)
        new Building(code: '935', name: '935 - SEDE SECTOR CAN     ', coordinates: '4.648011192666337&-74.09578800201416').save(flush: true)
    }

}
