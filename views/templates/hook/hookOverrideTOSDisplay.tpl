{**
 * 2007-2015 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 *  @author 	PrestaShop SA <contact@prestashop.com>
 *  @copyright  2007-2015 PrestaShop SA
 *  @license    http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 *}

<div class="row">
    <div class="col-xs-12 col-md-12">
        <div class="tnc_box">
            <p class="checkbox">
                {if isset($conditions) && $conditions}
                    <input type="checkbox" name="cgv" id="cgv" value="1" {if $checkedTOS}checked="checked"{/if}/>
                {else}
                    <input type="checkbox" name="cgv" id="cgv" value="1" checked style="display:none;"/>
                {/if}
                {if isset($link_conditions) && $link_conditions}
                    <label for="cgv">{l s='I agree to the' mod='advancedeucompliance'}</label> <a href="{$link_conditions|escape:'html':'UTF-8'}" class="iframe" rel="nofollow">{l s='terms of service'  mod='advancedeucompliance'}</a>
                {/if}
                {if isset($link_revocations) && $link_revocations}
                    <label for="cgv">{l s='and'  mod='advancedeucompliance'}</label> <a href="{$link_revocations|escape:'html':'UTF-8'}" class="iframe" rel="nofollow">{l s='terms of revocation' mod='advancedeucompliance'}</a>
                {/if}
                <label for="cgv">{l s='adhire to them unconditionally.'  mod='advancedeucompliance'}</label>
            </p>
            <script type="text/javascript">
                $(document).ready(function(){
                    if (!!$.prototype.fancybox)
                        $("a.iframe").fancybox({
                            'type': 'iframe',
                            'width': 600,
                            'height': 600
                        });
                })
            </script>
        </div>
        {if $has_virtual_product}
        <div class="tnc_box">
            <p class="carrier_title">{l s='Revocation of virtual products' mod='advancedeucompliance'}</p>
            <p class="checkbox">
                <input type="checkbox" name="revocation_vp_terms_agreed" id="revocation_vp_terms_agreed" value="1"/>
                <label for="revocation_vp_terms_agreed">{l s='I agree that the digital products in my cart can not be returned or refunded due to the nature of such products.' mod='advancedeucompliance'}</label>
            </p>
        </div>
        <script type="text/javascript">
            /*
            *  we have to add new function on 'click' on #confirmOrder in themes/default-bootstrap/js/advanced-payment-api.js
            */
            $(document).ready(function() {
                // unbind
                $('#confirmOrder').unbind('click');

                //new one
                var has_virtual_product = true;
                var handler = new PaymentOptionHandler();
                $('#confirmOrder').on('click', function(event){
                    /* Avoid any further action */
                    event.preventDefault();
                    event.stopPropagation();

                    if (!handler.checkTOS())
                    {
                        alert('Please check TOS box first !')
                        return;
                    }

                    if (has_virtual_product &&  !$('#revocation_vp_terms_agreed').is(':checked'))
                    {
                        alert('Please check \'Revocation of virtual products\' box first !')
                        return;
                    }

                    var payment_details = handler.getSelectedPaymentOptionDetails();
                    if (payment_details !== false && payment_details.action) {
                        handler.submitPaymentOption(payment_details.action, payment_details.data);
                    } else if (!payment_details.action && payment_details.has_form === true) {
                        payment_details.form_to_submit.submit();
                    } else {
                        alert('An error occured please be sure you have properly selected your payment option!');
                        return;
                    }
                });
            });
        </script>
        {/if}
    </div>
</div>