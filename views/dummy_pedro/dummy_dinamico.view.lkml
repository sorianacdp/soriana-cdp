view: dummy_dinamico {
  derived_table: {
    sql: -----Año anterior:

with anio_anterior as (

          with rango_fecha as (
            select
            --fecha inicio
            format_date('%Y%m%d',DATE_SUB(DATE(max(FechaHoraTicket)), INTERVAL 365 DAY)) as  fecha_inicio,
            --semana maxima del rango
            cast( format_date('%U', parse_date("%Y%m%d",max(format_date('%Y%m%d',FechaHoraTicket)))) as INT) as max_semana,
            --fecha final 8 semanas antes, o 56 dias--- 10 semanas 70 dias
              format_date('%Y%m%d',DATE_SUB(DATE(max(FechaHoraTicket)), INTERVAL 455 DAY)) as fecha_final,
          from `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`),
      ------------------------------
      --------------------------------
        prep as (
  select
  distinct format_date('%Y%m%d',FechaHoraTicket) as fecha,
  IdClienteSk as clientes,
  IdTienda as tienda,
  count (distinct IdClienteSk) as conteoCompras,
  ImporteVentaNeta as ticket,
  from `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`,rango_fecha
  where  format_date('%Y%m%d',FechaHoraTicket) <= rango_fecha.fecha_inicio and  format_date('%Y%m%d',FechaHoraTicket) >=rango_fecha.fecha_final and IdClienteSk is not null
  group by 1,2,3,5
  ),

nacimientoSoriana as (
select
distinct IdClienteSk as idclientes,
DATE_DIFF(CURRENT_DATE(), parse_date("%Y%m%d",min(format_date('%Y%m%d',FechaHoraTicket))), DAY)  as diasDeVida,
min(format_date('%Y-%m-%d',FechaHoraTicket)) as fechaNacimientoSoriana,

from `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`
where  format_date('%Y%m%d',FechaHoraTicket) between '20210101' and format_date('%Y%m%d',date_sub(current_date(), interval 1 day)) and IdClienteSk is not null
group by 1
),

----------------------------
----------------------------
----canal del cliente
----canal del cliente
ventaTienda as (
SELECT
distinct IdClienteSk as IdClienteSkvt,
'OFFLINE' as canalCliente
FROM `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`
where EsVentaInternet = false and IdCanal= 7 ),

ventaInternet as (
SELECT
distinct IdClienteSk as IdClienteSkvi,
'ONLINE' as canalCliente
FROM `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`
where EsVentaInternet= true and IdCanal= 3 ),

omni as (select
distinct vt.IdClienteSkvt as clienteOmni,
'OMNICANAL' as canalCliente
from ventaTienda as vt
inner join ventaInternet as vi on (vt.IdClienteSkvt = vi.IdClienteSkvi)),

union_OFFON as (
select IdClienteSkvt as idclienteun, canalCliente  from ventaTienda
union distinct
select * from ventaInternet),

canalorigen as (select
distinct un.idclienteun as idclienteun,
un.canalCliente as canalCliente,
case
when om.clienteOmni is not null then 'true'
else 'false'
end as omnicanal
from union_OFFON as un
left join omni as om on(un.idclienteun=om.clienteOmni))



---------------------------------------
--------------------------------------
---------------------------


select
--info cliente
distinct cast(p.clientes as STRING) as idCliente,
cp.GRClienteId as GRClienteId,
p.tienda as idTienda,
ns.fechaNacimientoSoriana,
ct.canalCliente as origenCliente,
ct.omnicanal as omnicanal,
cp.nombre as nombre,
cp.apellidoPaterno as apellido,
format_date('%Y-%m-%d',cp.fechaNacimiento) as fechaNacimiento,
cp.sexo as sexo,
cp.correo as correo,

--info compras
format_date('%Y', parse_date("%Y%m%d",fecha))as anio,
format_date('%U', parse_date("%Y%m%d",fecha))  as semana,
DATE_DIFF(CURRENT_DATE(), parse_date("%Y%m%d",fecha), WEEK) as haceNSemanas,
sum(p.ticket) as tickeTotal,
sum(p.conteoCompras) as conteoCompras,
sum(p.ticket)/sum(p.conteoCompras) as ticketPromedio,
--tipo de cliente
--tipo de cliente
case
--cliente nuevo
when (sum(p.conteoCompras)= 1) then 'CLIENTE NUEVO'

--cliente prospecto
when (sum(p.conteoCompras)= 0) then 'CLIENTE PROSPECTO'

--cliente premium
when (sum(p.conteoCompras)>= 4) and (sum(p.ticket)/sum(p.conteoCompras) > 570) then 'CLIENTE PREMIUM'

--cliente valioso
when (sum(p.conteoCompras)>= 3 and sum(p.conteoCompras)< 4) and (sum(p.ticket)/sum(p.conteoCompras) > 570) then 'CLIENTE VALIOSO'
when (sum(p.conteoCompras)>= 4) and (sum(p.ticket)/sum(p.conteoCompras) >= 150 and sum(p.ticket)/sum(p.conteoCompras) <= 570) then 'CLIENTE VALIOSO'

--cliente potencial
when (sum(p.conteoCompras)> 1 and sum(p.conteoCompras)< 3) and (sum(p.ticket)/sum(p.conteoCompras) > 570) then 'CLIENTE POTENCIAL'
when (sum(p.conteoCompras)>= 4) and (sum(p.ticket)/sum(p.conteoCompras) < 150) then 'CLIENTE POTENCIAL'
when (sum(p.conteoCompras)>= 3 and sum(p.conteoCompras)< 4) and (sum(p.ticket)/sum(p.conteoCompras) >=150 and sum(p.ticket)/sum(p.conteoCompras) <= 570) then 'CLIENTE POTENCIAL'

---cliente no comprometido
when (sum(p.conteoCompras)>= 3 and sum(p.conteoCompras)< 4) and (sum(p.ticket)/sum(p.conteoCompras) < 150) then 'NO COMPROMETIDO'
when (sum(p.conteoCompras)> 1 and sum(p.conteoCompras)< 3) and (sum(p.ticket)/sum(p.conteoCompras) < 150) then 'NO COMPROMETIDO'
when (sum(p.conteoCompras)>= 1 and sum(p.conteoCompras)<= 2) and (sum(p.ticket)/sum(p.conteoCompras) < 150) then 'NO COMPROMETIDO'
when (sum(p.conteoCompras)> 1 and sum(p.conteoCompras)< 3) and (sum(p.ticket)/sum(p.conteoCompras) >= 150 and sum(p.ticket)/sum(p.conteoCompras) <= 570) then 'NO COMPROMETIDO'
else '(not set )'
end as tipoCliente

from prep as p
left join `costumer-data-proyect.customer_data_platform.cdp_synapse_clientes_productivos` as cp on (p.clientes=cp.IdClienteSk)
left join nacimientoSoriana as ns on ( p.clientes= ns.idclientes)
left join canalorigen as ct on ( p.clientes=ct.idclienteun)
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14
order by semana desc, idCliente desc),

--------------------------------
------------------------------------------------------------------------------

anio_actual as (with rango_fecha as (
            select
            --fecha inicio
            max(format_date('%Y%m%d',FechaHoraTicket)) as  fecha_inicio,
            --semana maxima del rango
            cast( format_date('%U', parse_date("%Y%m%d",max(format_date('%Y%m%d',FechaHoraTicket)))) as INT) as max_semana,
            --fecha final 8 semanas antes, o 56 dias--- 10 semanas 70 dias
              format_date('%Y%m%d',DATE_SUB(DATE(max(FechaHoraTicket)), INTERVAL 90 DAY)) as fecha_final,
          from `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`),
      ------------------------------
      --------------------------------
        prep as (
  select
  distinct format_date('%Y%m%d',FechaHoraTicket) as fecha,
  IdClienteSk as clientes,
  IdTienda as tienda,
  count (distinct IdClienteSk) as conteoCompras,
  ImporteVentaNeta as ticket,
  from `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`,rango_fecha
  where  format_date('%Y%m%d',FechaHoraTicket) <= rango_fecha.fecha_inicio and  format_date('%Y%m%d',FechaHoraTicket) >=rango_fecha.fecha_final and IdClienteSk is not null
  group by 1,2,3,5
  ),

nacimientoSoriana as (
select
distinct IdClienteSk as idclientes,
DATE_DIFF(CURRENT_DATE(), parse_date("%Y%m%d",min(format_date('%Y%m%d',FechaHoraTicket))), DAY)  as diasDeVida,
min(format_date('%Y-%m-%d',FechaHoraTicket)) as fechaNacimientoSoriana,

from `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`
where  format_date('%Y%m%d',FechaHoraTicket) between '20210101' and format_date('%Y%m%d',date_sub(current_date(), interval 1 day)) and IdClienteSk is not null
group by 1
),

----------------------------
----------------------------
----canal del cliente
ventaTienda as (
SELECT
distinct IdClienteSk as IdClienteSkvt,
'OFFLINE' as canalCliente
FROM `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`
where EsVentaInternet = false and IdCanal= 7 ),

ventaInternet as (
SELECT
distinct IdClienteSk as IdClienteSkvi,
'ONLINE' as canalCliente
FROM `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`
where EsVentaInternet= true and IdCanal= 3 ),

omni as (select
distinct vt.IdClienteSkvt as clienteOmni,
'OMNICANAL' as canalCliente
from ventaTienda as vt
inner join ventaInternet as vi on (vt.IdClienteSkvt = vi.IdClienteSkvi)),

union_OFFON as (
select IdClienteSkvt as idclienteun, canalCliente  from ventaTienda
union distinct
select * from ventaInternet),

canalorigen as (select
distinct un.idclienteun as idclienteun,
un.canalCliente as canalCliente,
case
when om.clienteOmni is not null then 'true'
else 'false'
end as omnicanal
from union_OFFON as un
left join omni as om on(un.idclienteun=om.clienteOmni))

---------------------------------------------
-----------------------------------------------
--------------------------

select
--info cliente
  distinct cast(p.clientes as STRING) as idCliente,
cp.GRClienteId as GRClienteId,
p.tienda as idTienda,
ns.fechaNacimientoSoriana,
ct.canalCliente as origenCliente,
ct.omnicanal as omnicanal,
cp.nombre as nombre,
cp.apellidoPaterno as apellido,
format_date('%Y-%m-%d',cp.fechaNacimiento) as fechaNacimiento,
cp.sexo as sexo,
cp.correo as correo,

--info compras
format_date('%Y', parse_date("%Y%m%d",fecha))  as anio,
format_date('%U', parse_date("%Y%m%d",fecha))  as semana,
DATE_DIFF(CURRENT_DATE(), parse_date("%Y%m%d",fecha), WEEK) as haceNSemanas,
sum(p.ticket) as tickeTotal,
sum(p.conteoCompras) as conteoCompras,
sum(p.ticket)/sum(p.conteoCompras) as ticketPromedio,
--tipo de cliente
--tipo de cliente
case
--cliente nuevo
when (sum(p.conteoCompras)= 1) then 'CLIENTE NUEVO'

--cliente prospecto
when (sum(p.conteoCompras)= 0) then 'CLIENTE PROSPECTO'

--cliente premium
when (sum(p.conteoCompras)>= 4) and (sum(p.ticket)/sum(p.conteoCompras) > 570) then 'CLIENTE PREMIUM'

--cliente valioso
when (sum(p.conteoCompras)>= 3 and sum(p.conteoCompras)< 4) and (sum(p.ticket)/sum(p.conteoCompras) > 570) then 'CLIENTE VALIOSO'
when (sum(p.conteoCompras)>= 4) and (sum(p.ticket)/sum(p.conteoCompras) >= 150 and sum(p.ticket)/sum(p.conteoCompras) <= 570) then 'CLIENTE VALIOSO'

--cliente potencial
when (sum(p.conteoCompras)> 1 and sum(p.conteoCompras)< 3) and (sum(p.ticket)/sum(p.conteoCompras) > 570) then 'CLIENTE POTENCIAL'
when (sum(p.conteoCompras)>= 4) and (sum(p.ticket)/sum(p.conteoCompras) < 150) then 'CLIENTE POTENCIAL'
when (sum(p.conteoCompras)>= 3 and sum(p.conteoCompras)< 4) and (sum(p.ticket)/sum(p.conteoCompras) >=150 and sum(p.ticket)/sum(p.conteoCompras) <= 570) then 'CLIENTE POTENCIAL'

---cliente no comprometido
when (sum(p.conteoCompras)>= 3 and sum(p.conteoCompras)< 4) and (sum(p.ticket)/sum(p.conteoCompras) < 150) then 'NO COMPROMETIDO'
when (sum(p.conteoCompras)> 1 and sum(p.conteoCompras)< 3) and (sum(p.ticket)/sum(p.conteoCompras) < 150) then 'NO COMPROMETIDO'
when (sum(p.conteoCompras)>= 1 and sum(p.conteoCompras)<= 2) and (sum(p.ticket)/sum(p.conteoCompras) < 150) then 'NO COMPROMETIDO'
when (sum(p.conteoCompras)> 1 and sum(p.conteoCompras)< 3) and (sum(p.ticket)/sum(p.conteoCompras) >= 150 and sum(p.ticket)/sum(p.conteoCompras) <= 570) then 'NO COMPROMETIDO'
else '(not set )'
end as tipoCliente

from prep as p
left join `costumer-data-proyect.customer_data_platform.cdp_synapse_clientes_productivos` as cp on (p.clientes=cp.IdClienteSk)
left join nacimientoSoriana as ns on ( p.clientes= ns.idclientes)
left join canalorigen as ct on ( p.clientes=ct.idclienteun)
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14
order by semana desc, idCliente desc)

select * from anio_actual
union all
select * from anio_anterior
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id_cliente {
    type: string
    sql: ${TABLE}.idCliente ;;
  }

  dimension: semana {
    type: string
    sql: ${TABLE}.semana ;;
  }

  dimension: ticke_total {
    type: number
    sql: ${TABLE}.tickeTotal ;;
  }

  dimension: conteo_compras {
    type: number
    sql: ${TABLE}.conteoCompras ;;
  }

  dimension: ticket_promedio {
    type: number
    sql: ${TABLE}.ticketPromedio ;;
  }

parameter: limSupCalClient {
  type: unquoted
  default_value: "570"
  allowed_value: {value: "570"}
  allowed_value: {value: "2000"}
  allowed_value: {value: "3000"}
  allowed_value: {value: "3500"}
}

  parameter: limInfCalClient {
    type: unquoted
    allowed_value: {value: "150"}
    allowed_value: {value: "200"}
    allowed_value: {value: "250"}
    allowed_value: {value: "300"}
    allowed_value: {value: "350"}
    allowed_value: {value: "400"}

  }

  parameter: conteoR4{
    type: unquoted
    default_value: "4"
    allowed_value: {value: "4"}
    allowed_value: {value: "5"}
    allowed_value: {value: "6"}
    allowed_value: {value: "7"}
    allowed_value: {value: "8"}
  }
  parameter: conteoR3 {
    type: unquoted
    default_value: "3"
    allowed_value: {value: "3"}
    allowed_value: {value: "4"}
    allowed_value: {value: "5"}

  }

  parameter: conteoR1 {
    type: unquoted
    default_value: "1"
    allowed_value: {value: "1"}
    allowed_value: {value: "2"}
    allowed_value: {value: "3"}
  }
  parameter: conteoR0 {
    type: unquoted
    default_value: "0"
    allowed_value: {value: "0"}
    allowed_value: {value: "1"}
  }

  dimension: tipoCliente {
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



  set: detail {
    fields: [id_cliente, semana, ticke_total, conteo_compras, ticket_promedio]
  }
}
