# Orbix Payment Validation manifest for Odoo

__manifest__ = {
    'name': 'Orbix Payment Validation',
    'version': '16.0.1.0.0',
    'category': 'Accounting/Payment',
    'summary': 'Módulo para testing de validaciones de tarjetas de crédito - Babel Testing',
    'description': '''
        Módulo personalizado de Orbix para testing de validaciones de tarjetas de crédito.
        Diseñado específicamente para que Babel pueda hacer testing de validaciones.
        
        Características:
        - Validación de números de tarjeta
        - Testing de diferentes tipos de tarjeta
        - Simulación de transacciones
        - API para integración con sistema principal
    ''',
    'author': 'Orbix Systems - YovoyTech',
    'website': 'https://github.com/yovoyTecSRL/orbix',
    'depends': ['base', 'account', 'payment'],
    'data': [
        'security/ir.model.access.csv',
        'views/payment_validation_views.xml',
        'data/payment_test_data.xml',
    ],
    'demo': [
        'demo/demo_data.xml',
    ],
    'installable': True,
    'auto_install': False,
    'application': True,
    'license': 'LGPL-3',
}
