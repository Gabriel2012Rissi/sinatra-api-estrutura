class CarDecorator < Draper::Decorator
  delegate_all

  def price_formatted
    object.price.to_fs(
      :currency, 
      delimiter: I18n.t('number.currency.format.delimiter'),
      format: I18n.t('number.currency.format.format'),
      precision: I18n.t('number.currency.format.precision'),
      separator: I18n.t('number.currency.format.separator'),
      significant: I18n.t('number.currency.format.significant'),
      strip_insignificant_zeros: I18n.t('number.currency.format.strip_insignificant_zeros'),
      unit: I18n.t('number.currency.format.unit')
    )
  end
end