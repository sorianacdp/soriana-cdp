view: cdp_soriana_rfm_ltv {
  derived_table: {
    sql: select *
      from `costumer-data-proyect.customer_data_platform.cdp-soriana-RFM_LTV`
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: countdistinct {
    type: count_distinct
    sql: ${TABLE}.IdClienteSk ;;
  }

  dimension: id_cliente_sk {
    type: string
    sql: ${TABLE}.IdClienteSk ;;
  }

  dimension: grcliente_id {
    type: string
    sql: ${TABLE}.GRClienteId ;;
  }

  dimension: id_tienda {
    type: string
    sql: ${TABLE}.IdTienda ;;
  }

  dimension: tienda {
    type: string
    sql: ${TABLE}.Tienda ;;
  }

  dimension: formato {
    type: string
    sql: ${TABLE}.Formato ;;
  }

  dimension: estado {
    type: string
    sql: ${TABLE}.Estado ;;
  }

  dimension: semana {
    type: string
    sql: ${TABLE}.semana ;;
  }

  dimension: semana_ultima_compra {
    type: string
    sql: ${TABLE}.SemanaUltimaCompra ;;
  }

  dimension: resta_semana {
    type: number
    sql: ${TABLE}.restaSemana ;;
  }

  dimension: hace_nsemanas {
    type: number
    sql: ${TABLE}.haceNSemanas ;;
  }

  dimension: anio {
    type: string
    sql: ${TABLE}.anio ;;
  }

  dimension: mes {
    type: string
    sql: ${TABLE}.mes ;;
  }

  dimension: fecha_nacimiento_soriana {
    type: string
    sql: ${TABLE}.fechaNacimientoSoriana ;;
  }

  dimension: dias_de_vida {
    type: number
    sql: ${TABLE}.diasDeVida ;;
  }

  dimension: recencia {
    type: number
    sql: ${TABLE}.recencia ;;
  }

  dimension: fecha_ultima_compra {
    type: string
    sql: ${TABLE}.fechaUltimaCompra ;;
  }

  dimension: sexo {
    type: string
    sql: ${TABLE}.Sexo ;;
  }

  dimension: edad {
    type: number
    sql: ${TABLE}.Edad ;;
  }

  dimension: conteo_compras {
    type: number
    sql: ${TABLE}.conteoCompras ;;
  }

  dimension: ticket_promedio {
    type: number
    sql: ${TABLE}.ticketPromedio ;;
  }

  dimension: canal_exclusivo {
    type: string
    sql: ${TABLE}.canalExclusivo ;;
  }

  dimension: frecuenciade_compra {
    type: string
    sql: ${TABLE}.frecuenciadeCompra ;;
  }

  dimension: tipo_cliente {
    type: string
    sql: ${TABLE}.tipoCliente ;;
  }

  dimension: categoria_compra1 {
    type: string
    sql: ${TABLE}.categoriaCompra1 ;;
  }

  dimension: categoria_compra2 {
    type: string
    sql: ${TABLE}.categoriaCompra2 ;;
  }

  dimension: categoria_compra3 {
    type: string
    sql: ${TABLE}.categoriaCompra3 ;;
  }

  dimension: categoria_compra4 {
    type: string
    sql: ${TABLE}.categoriaCompra4 ;;
  }

  dimension: categoria_compra5 {
    type: string
    sql: ${TABLE}.categoriaCompra5 ;;
  }

  dimension: categoria_visto1 {
    type: string
    sql: ${TABLE}.categoriaVisto1 ;;
  }

  dimension: categoria_visto2 {
    type: string
    sql: ${TABLE}.categoriaVisto2 ;;
  }

  dimension: categoria_visto3 {
    type: string
    sql: ${TABLE}.categoriaVisto3 ;;
  }

  dimension: categoria_visto4 {
    type: string
    sql: ${TABLE}.categoriaVisto4 ;;
  }

  dimension: categoria_visto5 {
    type: string
    sql: ${TABLE}.categoriaVisto5 ;;
  }
############################tipo de cliente CLC
#################

  parameter: limSupCalClient {
    type: number
    default_value: "570"
  }

  parameter: limInfCalClient {
    type: number
    default_value: "150"

  }

  parameter: conteoR4{
    type: number
    default_value: "4"

  }
  parameter: conteoR3 {
    type: number
    default_value: "3"

  }

  parameter: conteoR1 {
    type: number
    default_value: "1"

  }
  parameter: conteoR0 {
    type: number
    default_value: "0"
  }

  dimension: tipoClienteCLC {
    case: {
      #cliente nuevo
      when: {
        sql: ${TABLE}.conteoCompras = {% parameter conteoR1%} ;;
        label: "CLIENTE NUEVO"
      }
      #cliente prospecto
      when: {
        sql: ${TABLE}.conteoCompras = {% parameter conteoR0%} ;;
        label: "CLIENTE PROSPECTO"
      }
      #cliente premium
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR4%}) and (${TABLE}.ticketPromedio > {% parameter limSupCalClient%})   ;;
        label: "CLIENTE PREMIUM"
      }

      #cliente valiosos
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR3%} and ${TABLE}.conteoCompras < {% parameter conteoR4%} ) and (${TABLE}.ticketPromedio > {% parameter limSupCalClient%}) ;;
        label: "CLIENTE VALIOSO"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR4%}) and (${TABLE}.ticketPromedio >= {% parameter limInfCalClient%} and ${TABLE}.ticketPromedio <= {% parameter limSupCalClient%}) ;;
        label: "CLIENTE VALIOSO"
      }

      #cliente potencial
      when: {
        sql: (${TABLE}.conteoCompras > {% parameter conteoR1%} and ${TABLE}.conteoCompras < {% parameter conteoR3%} ) and (${TABLE}.ticketPromedio > {% parameter limSupCalClient%}) ;;
        label: "CLIENTE POTENCIAL"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR3%} and ${TABLE}.conteoCompras < {% parameter conteoR4%}) and (${TABLE}.ticketPromedio >= {% parameter limInfCalClient%} and ${TABLE}.ticketPromedio <= {% parameter limSupCalClient%}) ;;
        label: "CLIENTE POTENCIAL"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR4%}) and (${TABLE}.ticketPromedio < {% parameter limInfCalClient%} ) ;;
        label: "CLIENTE POTENCIAL"
      }

      # cliente no comprometido
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR3%} and ${TABLE}.conteoCompras < {% parameter conteoR4%}) and (${TABLE}.ticketPromedio < {% parameter limInfCalClient%} ) ;;
        label: "NO COMPROMETIDO"
      }
      when: {
        sql: (${TABLE}.conteoCompras > {% parameter conteoR1%} and ${TABLE}.conteoCompras < {% parameter conteoR3%}) and (${TABLE}.ticketPromedio < {% parameter limInfCalClient%} ) ;;
        label: "NO COMPROMETIDO"
      }
      when: {
        sql: (${TABLE}.conteoCompras > {% parameter conteoR1%} and ${TABLE}.conteoCompras <  {% parameter conteoR3%}) and (${TABLE}.ticketPromedio >= {% parameter limInfCalClient%} and ${TABLE}.ticketPromedio <= {% parameter limSupCalClient%}) ;;
        label: "NO COMPROMETIDO"
      }

      else: "(not set)"
    }
  }





#####################conteo de clientes por calificacion

  measure: clientePremium {
    type: count_distinct
    sql: ${TABLE}.IdClienteSk ;;
    filters: [tipoClienteCLC: "CLIENTE PREMIUM"]
  }

  measure: clienteValioso {
    type: count_distinct
    sql: ${TABLE}.IdClienteSk ;;
    filters: [tipoClienteCLC: "CLIENTE VALIOSO"]
  }

  measure: clientePotencial {
    type: count_distinct
    sql: ${TABLE}.IdClienteSk ;;
    filters: [tipoClienteCLC: "CLIENTE POTENCIAL"]
  }

  measure: clienteNoComprometido {
    type: count_distinct
    sql: ${TABLE}.IdClienteSk ;;
    filters: [tipoClienteCLC: "NO COMPROMETIDO"]
  }

  measure: clienteNuevo {
    type: count_distinct
    sql: ${TABLE}.IdClienteSk ;;
    filters: [tipoClienteCLC: "CLIENTE NUEVO"]
  }

  measure: clienteProspecto {
    type: count_distinct
    sql: ${TABLE}.IdClienteSk ;;
    filters: [tipoClienteCLC: "CLIENTE PROSPECTO"]
  }




######### Calculo RFM ##################
########################################

  parameter: limSupTicketRFM {
    type: number
    default_value: "2000"
  }

  parameter: limInfTicketRFM {
    type: number
    default_value: "1000"
  }

#######################################################################

  dimension: RFMClientesNuevosgm {
    case: {
      #GASTAN MUCHO
      when: {
        sql: ${TABLE}.ticketPromedio > {% parameter limSupTicketRFM%} ;;
        label: "GASTAN MUCHO"
      }
      else: "(not set)"
    }
  }

  dimension: RFMClientesNuevosgmo {
    case: {
      #cliente GASTAN MODERADO
      when: {
        sql: (${TABLE}.ticketPromedio >= {% parameter limInfTicketRFM%} and ${TABLE}.ticketPromedio <= {% parameter limSupTicketRFM%}) ;;
        label: "GASTAN MODERADO"
        }
      else: "(not set)"
    }
  }

  dimension: RFMClientesNuevosgmp {
    case: {
      #cliente GASTAN POCO
      when: {
        sql: (${TABLE}.ticketPromedio < {% parameter limInfTicketRFM%}) ;;
        label: "GASTAN POCO"
      }

      else: "(not set)"
    }
  }
  #################################################
#######################################################################

###########GASTAN MUCHO
  dimension: RFMClientesPremium1 {
    case: {
      #GASTAN MUCHO
      when: {
        sql: ${TABLE}.ticketPromedio > {% parameter limSupTicketRFM%} and ${TABLE}.frecuenciadeCompra='COMPRA CADA SEMANA' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }

  dimension: RFMClientesPremium2 {
    case: {
      #GASTAN MUCHO
      when: {
        sql: ${TABLE}.ticketPromedio > {% parameter limSupTicketRFM%} and ${TABLE}.frecuenciadeCompra='COMPRA CADA DOS SEMANAS' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }

  dimension: RFMClientesValioso3 {
    case: {
      #GASTAN MUCHO
      when: {
        sql: ${TABLE}.ticketPromedio > {% parameter limSupTicketRFM%} and ${TABLE}.frecuenciadeCompra='COMPRA CADA TRES SEMANAS' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }

  dimension: RFMClientesValioso4 {
    case: {
      #GASTAN MUCHO
      when: {
        sql: ${TABLE}.ticketPromedio > {% parameter limSupTicketRFM%} and ${TABLE}.frecuenciadeCompra='COMPRA CADA CUATRO SEMANAS' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }

  dimension: RFMClientesPotencial6 {
    case: {
      #GASTAN MUCHO
      when: {
        sql: ${TABLE}.ticketPromedio > {% parameter limSupTicketRFM%} and ${TABLE}.frecuenciadeCompra='COMPRA CADA SEIS SEMANAS' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }

###########GASTAN MODERADO
  dimension: RFMClientesValioso1 {
    case: {
      #GASTAN MODERADO
      when: {
        sql: (${TABLE}.ticketPromedio >= {% parameter limInfTicketRFM%} and ${TABLE}.ticketPromedio <= {% parameter limSupTicketRFM%}) and ${TABLE}.frecuenciadeCompra='COMPRA CADA SEMANA' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }

  dimension: RFMClientesValioso2 {
    case: {
      #GASTAN MODERADO
      when: {
        sql: (${TABLE}.ticketPromedio >= {% parameter limInfTicketRFM%} and ${TABLE}.ticketPromedio <= {% parameter limSupTicketRFM%}) and ${TABLE}.frecuenciadeCompra='COMPRA CADA DOS SEMANAS' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }

  dimension: RFMClientesPotencial3 {
    case: {
      #GASTAN MODERADO
      when: {
        sql: (${TABLE}.ticketPromedio >= {% parameter limInfTicketRFM%} and ${TABLE}.ticketPromedio <= {% parameter limSupTicketRFM%}) and ${TABLE}.frecuenciadeCompra='COMPRA CADA TRES SEMANAS' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }

  dimension: RFMClientesPotencial4 {
    case: {
      #GASTAN MODERADO
      when: {
        sql: (${TABLE}.ticketPromedio >= {% parameter limInfTicketRFM%} and ${TABLE}.ticketPromedio <= {% parameter limSupTicketRFM%}) and ${TABLE}.frecuenciadeCompra='COMPRA CADA CUATRO SEMANAS' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }

  dimension: RFMClientesNoComprometido6 {
    case: {
      #GASTAN MODERADO
      when: {
        sql: (${TABLE}.ticketPromedio >= {% parameter limInfTicketRFM%} and ${TABLE}.ticketPromedio <= {% parameter limSupTicketRFM%}) and ${TABLE}.frecuenciadeCompra='COMPRA CADA SEIS SEMANAS' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }

###########GASTAN POCO
  dimension: RFMClientesPotencial1 {
    case: {
      #GASTAN POCO
      when: {
        sql: (${TABLE}.ticketPromedio < {% parameter limInfTicketRFM%}) and ${TABLE}.frecuenciadeCompra='COMPRA CADA SEMANA' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }

  dimension: RFMClientesPotencial2 {
    case: {
      #GASTAN POCO
      when: {
        sql: (${TABLE}.ticketPromedio < {% parameter limInfTicketRFM%}) and ${TABLE}.frecuenciadeCompra='COMPRA CADA DOS SEMANAS' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }

  dimension: RFMClientesNoComprometido3 {
    case: {
      #GASTAN POCO
      when: {
        sql: (${TABLE}.ticketPromedio < {% parameter limInfTicketRFM%}) and ${TABLE}.frecuenciadeCompra='COMPRA CADA TRES SEMANAS' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }

  dimension: RFMClientesNoComprometido4 {
    case: {
      #GASTAN POCO
      when: {
        sql: (${TABLE}.ticketPromedio < {% parameter limInfTicketRFM%}) and ${TABLE}.frecuenciadeCompra='COMPRA CADA CUATRO SEMANAS' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }

  dimension: RFMClientesNoComprometido6_2 {
    case: {
      #GASTAN POCO
      when: {
        sql: (${TABLE}.ticketPromedio < {% parameter limInfTicketRFM%}) and ${TABLE}.frecuenciadeCompra='COMPRA CADA SEIS SEMANAS' ;;
        label: "Conteo de Clientes"
      }
      else: "(not set)"
    }
  }


  #####
  #################################################









  ############## CALCULO LTV ###########################
  #######################################################

  ###suma ticket por tipo cliente
  measure: tikclientePremium {
    type: sum
    sql: ${TABLE}.ticketPromedio ;;
    filters: [tipoClienteCLC: "CLIENTE PREMIUM"]
  }

  measure: tikclienteValioso {
    type: sum
    sql: ${TABLE}.ticketPromedio ;;
    filters: [tipoClienteCLC: "CLIENTE VALIOSO"]
  }

  measure: tikclientePotencial {
    type: sum
    sql: ${TABLE}.ticketPromedio ;;
    filters: [tipoClienteCLC: "CLIENTE POTENCIAL"]
  }

  measure: tikclienteNoComprometido {
    type: sum
    sql: ${TABLE}.ticketPromedio ;;
    filters: [tipoClienteCLC: "NO COMPROMETIDO"]
  }

  measure: tikclienteNuevo {
    type: sum
    sql: ${TABLE}.ticketPromedio ;;
    filters: [tipoClienteCLC: "CLIENTE NUEVO"]
  }

  measure: tikclienteProspecto {
    type: sum
    sql: ${TABLE}.ticketPromedio ;;
    filters: [tipoClienteCLC: "CLIENTE PROSPECTO"]
  }

  dimension: mapa {
    map_layer_name: mexico
    sql: ${TABLE}.Estado  ;;
  }
  ##########################################################

  set: detail {
    fields: [
      id_cliente_sk,
      grcliente_id,
      id_tienda,
      tienda,
      formato,
      estado,
      semana,
      semana_ultima_compra,
      resta_semana,
      hace_nsemanas,
      anio,
      mes,
      fecha_nacimiento_soriana,
      dias_de_vida,
      recencia,
      fecha_ultima_compra,
      sexo,
      edad,
      conteo_compras,
      ticket_promedio,
      canal_exclusivo,
      frecuenciade_compra,
      tipoClienteCLC,
      tipo_cliente,
      categoria_compra1,
      categoria_compra2,
      categoria_compra3,
      categoria_compra4,
      categoria_compra5,
      categoria_visto1,
      categoria_visto2,
      categoria_visto3,
      categoria_visto4,
      categoria_visto5
    ]
  }
}
