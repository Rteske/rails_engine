class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items, dependent: :destroy

  attr_accessor :revenue, :count

  def self.search_by_name(search_string)
    search_string = search_string.downcase
    Merchant.where('merchants.name LIKE ?', "%#{search_string}%")
  end

  def self.merchants_by_revenue(quantity)
    joins(items: { invoice_items: { invoice: :transactions } })
      .select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
      .where('transactions.result = ?', 'success')
      .where('invoices.status = ?', 'shipped')
      .group('merchants.id')
      .order(total_revenue: :desc)
      .limit(quantity)
  end

  def self.merchants_by_items_sold(quantity)
    joins(items: { invoices: :transactions })
      .select('merchants.*, SUM(invoice_items.quantity) AS total_items_sold')
      .where('transactions.result = ?', 'success')
      .where('invoices.status = ?', 'shipped')
      .group('merchants.id')
      .order(total_items_sold: :desc)
      .limit(quantity)
  end

  def revenue_by_merchant
    items.joins(invoices: :transactions)
      .select('SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
      .where('transactions.result = ?', 'success')
      .where('invoices.status = ?', 'shipped')
  end
end
