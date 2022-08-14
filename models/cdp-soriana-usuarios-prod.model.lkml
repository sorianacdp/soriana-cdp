connection: "cdp-soriana-dataset-prod"

include: "/views/cdp-ususarios-prod/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
include: "/Dashboards/pincipal.dashboard.lookml"
# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
explore: cdp_soriana_usuario_iden_compra_ga_sfcc {}
explore: cdp_soriana_usuario_tres_fuentes_ga_sfcc_synapes_prub1 {}
