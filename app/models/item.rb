class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validate :name, :description, :unit_price
  validates_associated :merchant

  attr_accessor :revenue

  def self.search_all_items_by_name(search_string)
    self.where('items.name ILIKE ?', "%#{search_string}%").order(:name)
  end

  def self.items_by_revenue(quantity)
    joins(invoices: :transactions)
      .select('items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
      .where('transactions.result = ?', 'success')
      .where('invoices.status = ?', 'shipped')
      .group('items.id')
      .order(total_revenue: :desc)
      .limit(quantity)
  end
end
