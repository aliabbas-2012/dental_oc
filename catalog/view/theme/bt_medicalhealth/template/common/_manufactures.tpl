<?php $this->load->model('catalog/manufacturer'); ?>
<?php
$manufactures = $this->model_catalog_manufacturer->getManufacturers();

$manu_facts = isset($this->request->get['manu_f'])?explode(',',$this->request->get['manu_f']):array();
$uri = str_replace("amp;","",$_SERVER['REQUEST_URI']);

if(isset($this->request->get['manu_f'])){
    $replace = "&manu_f=".$this->request->get['manu_f'];
    $uri = str_replace($replace,"",$uri);
}

?>
<div id="column-left" class="four columns">
    <div class="main-column-left">
        <div class="box category">
            <div class="box-heading">Manufactures </div>
            <div class="box-content">
                <div class="box-category">
                    <ul>
                        <?php
                        foreach($manufactures as $manuf){
                        ?>
                        <li>
                            <input type="checkbox" class="manu_manuf" id="manuf_<?php echo $manuf['manufacturer_id']; ?>" value="<?php echo $manuf['manufacturer_id']; ?>" />
                            <a href="?route=product/category/&manuf=<?php echo $manuf['manufacturer_id']; ?>"><?php echo $manuf['name']; ?></a>
                        </li>

                        <?php
                        }

                        ?>
                    </ul>
                </div>
            </div>
        </div>

    </div>

</div>

<script>
    Object.defineProperty(Array.prototype, "remove", {
        enumerable: false,
        value: function(item) {
            var removeCounter = 0;

            for (var index = 0; index < this.length; index++) {
                if (this[index] === item) {
                    this.splice(index, 1);
                    removeCounter++;
                    index--;
                }
            }
            return removeCounter;
        }
    });
    var manu_factures = [];
    manu_factures = <?php  echo json_encode($manu_facts); ; ?> ;
    var uri = decodeURI(encodeURI('<?php echo $uri; ?>'));
    
            $(function() {

                for (ob in manu_factures) {
                    $("#manuf_" + manu_factures[ob]).prop("checked", 'checked');
                }
                $(".manu_manuf").bind("click", function() {
                    manu_factures = $.unique(manu_factures);

                    if ($(this).is(':checked')) {
                        manu_factures.push($(this).val());
                    }
                    else {
                        remove_val = $(this).val();
                        manu_factures.remove(remove_val.toString());
                    }
                    
                    url = uri;
                    if (manu_factures.length > 0) {
                        url = uri+'&manu_f=' + manu_factures.join(",");
                    }


                    window.location.href = url;


                })
            })
</script>    

