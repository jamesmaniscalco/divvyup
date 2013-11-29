# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



window.ItemType ||= {};

ItemType.show = () ->
  Charts.pieChart(usage_data, "usage-pie", "amount_used", "person_name")
  Charts.pieChart(purchase_data, "purchase-pie", "amount_purchased", "person_name")
  Charts.resize()
