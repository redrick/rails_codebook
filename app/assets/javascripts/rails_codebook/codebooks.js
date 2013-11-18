jQuery( function() {
    $('#cb_name').change(function() {
      $('#search-form').submit();
    })
  });

jQuery(function() {
  $('#form-codebook textarea').autosize();
  $('#add-codebook-link').click(function(event) {
    event.preventDefault();
    $('#form-codebook #codebook_value').val('');
    $('#form-codebook #codebook_name').val('');
    $('#form-codebook #codebook_cb_name').val('');
    $('#form-codebook #codebook_sequence').val('100');
    $('#form-codebook #codebook_deleted').val('0');
    $('#form-codebook #codebook_id').val('');
  });
  return $('.edit-codebook').click(function(event) {
    event.preventDefault();
    $('#form-codebook #codebook_value').val($(this).data('value'));
    $('#form-codebook #codebook_name').val($(this).data('name'));
    $('#form-codebook #codebook_cb_name').val($(this).data('cb-name'));
    $('#form-codebook #codebook_sequence').val($(this).data('sequence'));
    $('#form-codebook #codebook_deleted').val($(this).data('deleted'));
    $('#form-codebook #codebook_id').val($(this).data('id'));
  });
});
