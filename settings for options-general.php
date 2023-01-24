<?php
/**
 * Custom setting for options-general.php
 */
class general_settings {

    function __construct()
    {
        add_filter( 'admin_init' , array( &$this , 'clinto_register_fields' ) );
    }
    function clinto_register_fields() {
        register_setting( 'general', 'custom_field', 'esc_attr' );
        add_settings_field(
            'text_mk_email_aprovacao',
            '<label for="custom_field">'.__('mensagem' , 'custom_field' ).'</label>' , 
            array(&$this, 'fields_html') , 
            'general' );
    }
    function fields_html() {
        $value = get_option( 'custom_field');
        echo '<label>mensagem.</label>
        <textarea rows="6" style="width: 100%;" type="" name="custom_field"  />'.$value.'</textarea>';
    }
}
