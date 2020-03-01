<%= Spree.t('order_mailer.confirm_email.dear_customer') %>

<%= Spree.t('order_mailer.confirm_email.instructions') %>

============================================================
<%= Spree.t('order_mailer.confirm_email.order_summary', number: @order.number) %>
============================================================
<% @order.line_items.each do |item| %>
  <%= item.variant.sku %> <%= raw(item.variant.product.name) %> <%= raw(item.variant.options_text) -%> (<%=item.quantity%>) <%= Spree.t('at_symbol') %>  <%= item.single_money %> = <%= item.display_amount %>
<% end %>
============================================================
<%= Spree.t('order_mailer.subtotal') %> <%= @order.display_item_total %>
<% if @order.line_item_adjustments.exists? %>
  <% if @order.all_adjustments.promotion.eligible.exists? %>
    <% @order.all_adjustments.promotion.eligible.group_by(&:label).each do |label, adjustments| %>
<%= Spree.t(:promotion) %>: <%= label %> <%= Spree::Money.new(adjustments.sum(&:amount), currency: @order.currency) %>
    <% end %>
  <% end %>
<% end %>

<% @order.shipments.group_by { |s| s.selected_shipping_rate.try(:name) }.each do |name, shipments| %>
<%= Spree.t(:shipping) %>: <%= name %> <%= Spree::Money.new(shipments.sum(&:discounted_cost), currency: @order.currency) %>
<% end %>

<% if @order.all_adjustments.eligible.tax.exists? %>
  <% @order.all_adjustments.eligible.tax.group_by(&:label).each do |label, adjustments| %>
<%= Spree.t(:tax) %>: <%= label %> <%= Spree::Money.new(adjustments.sum(&:amount), currency: @order.currency) %>
  <% end %>
<% end %>

<% @order.adjustments.eligible.each do |adjustment| %>
  <% next if (adjustment.source_type == 'Spree::TaxRate') and (adjustment.amount == 0) %>
<%= adjustment.label %> <%= adjustment.display_amount %>
<% end %>
============================================================
<%= Spree.t('order_mailer.total') %> <%= @order.display_total %>

<%= Spree.t('order_mailer.confirm_email.thanks') %>
