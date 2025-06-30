from odoo import models, fields, api
from odoo.exceptions import ValidationError
import re
import luhn

class PaymentValidation(models.Model):
    _name = 'orbix.payment.validation'
    _description = 'Validación de Tarjetas de Crédito - Babel Testing'
    _rec_name = 'card_number_masked'

    # Campos básicos
    card_number = fields.Char(
        string='Número de Tarjeta',
        required=True,
        help='Número completo de la tarjeta para testing'
    )
    card_number_masked = fields.Char(
        string='Número Enmascarado',
        compute='_compute_masked_number',
        store=True
    )
    card_type = fields.Selection([
        ('visa', 'Visa'),
        ('mastercard', 'MasterCard'),
        ('amex', 'American Express'),
        ('discover', 'Discover'),
        ('other', 'Otro')
    ], string='Tipo de Tarjeta', compute='_compute_card_type', store=True)
    
    expiry_month = fields.Selection([
        ('01', '01'), ('02', '02'), ('03', '03'), ('04', '04'),
        ('05', '05'), ('06', '06'), ('07', '07'), ('08', '08'),
        ('09', '09'), ('10', '10'), ('11', '11'), ('12', '12')
    ], string='Mes de Expiración', required=True)
    
    expiry_year = fields.Char(string='Año de Expiración', required=True)
    cvv = fields.Char(string='CVV', required=True)
    
    # Campos de validación
    is_valid_luhn = fields.Boolean(
        string='Válido Luhn',
        compute='_compute_luhn_validation',
        store=True
    )
    is_valid_format = fields.Boolean(
        string='Formato Válido',
        compute='_compute_format_validation',
        store=True
    )
    is_expired = fields.Boolean(
        string='Expirada',
        compute='_compute_expiry_validation',
        store=True
    )
    
    # Campos de testing
    test_result = fields.Selection([
        ('pending', 'Pendiente'),
        ('approved', 'Aprobada'),
        ('declined', 'Rechazada'),
        ('error', 'Error')
    ], string='Resultado del Test', default='pending')
    
    test_notes = fields.Text(string='Notas del Test')
    babel_tester = fields.Char(string='Testeado por Babel')

    @api.depends('card_number')
    def _compute_masked_number(self):
        for record in self:
            if record.card_number:
                # Enmascarar todos menos los últimos 4 dígitos
                clean_number = re.sub(r'\D', '', record.card_number)
                if len(clean_number) >= 4:
                    masked = '*' * (len(clean_number) - 4) + clean_number[-4:]
                    record.card_number_masked = masked
                else:
                    record.card_number_masked = '*' * len(clean_number)
            else:
                record.card_number_masked = False

    @api.depends('card_number')
    def _compute_card_type(self):
        for record in self:
            if record.card_number:
                clean_number = re.sub(r'\D', '', record.card_number)
                if clean_number.startswith('4'):
                    record.card_type = 'visa'
                elif clean_number.startswith(('51', '52', '53', '54', '55')):
                    record.card_type = 'mastercard'
                elif clean_number.startswith(('34', '37')):
                    record.card_type = 'amex'
                elif clean_number.startswith('6'):
                    record.card_type = 'discover'
                else:
                    record.card_type = 'other'
            else:
                record.card_type = False

    @api.depends('card_number')
    def _compute_luhn_validation(self):
        for record in self:
            if record.card_number:
                clean_number = re.sub(r'\D', '', record.card_number)
                try:
                    record.is_valid_luhn = luhn.verify(clean_number)
                except:
                    record.is_valid_luhn = False
            else:
                record.is_valid_luhn = False

    @api.depends('card_number')
    def _compute_format_validation(self):
        for record in self:
            if record.card_number:
                clean_number = re.sub(r'\D', '', record.card_number)
                # Validar longitud según tipo de tarjeta
                if record.card_type == 'amex':
                    record.is_valid_format = len(clean_number) == 15
                else:
                    record.is_valid_format = len(clean_number) == 16
            else:
                record.is_valid_format = False

    @api.depends('expiry_month', 'expiry_year')
    def _compute_expiry_validation(self):
        from datetime import datetime
        current_date = datetime.now()
        
        for record in self:
            if record.expiry_month and record.expiry_year:
                try:
                    expiry_year = int(record.expiry_year)
                    expiry_month = int(record.expiry_month)
                    
                    if expiry_year < current_date.year:
                        record.is_expired = True
                    elif expiry_year == current_date.year and expiry_month < current_date.month:
                        record.is_expired = True
                    else:
                        record.is_expired = False
                except:
                    record.is_expired = True
            else:
                record.is_expired = True

    def action_test_payment(self):
        """Acción para que Babel pueda testear la validación"""
        for record in self:
            if record.is_valid_luhn and record.is_valid_format and not record.is_expired:
                record.test_result = 'approved'
                record.test_notes = f'Tarjeta válida - Testeada el {fields.Datetime.now()}'
            else:
                record.test_result = 'declined'
                errors = []
                if not record.is_valid_luhn:
                    errors.append('Falla validación Luhn')
                if not record.is_valid_format:
                    errors.append('Formato inválido')
                if record.is_expired:
                    errors.append('Tarjeta expirada')
                record.test_notes = f'Rechazada: {", ".join(errors)}'
        
        return {
            'type': 'ir.actions.client',
            'tag': 'display_notification',
            'params': {
                'message': 'Testing de validación completado',
                'type': 'success',
                'sticky': False,
            }
        }
