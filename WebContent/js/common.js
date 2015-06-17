/**
 * @author 郝威
 */

(function($) {
	$.fn.extend({
		clearForm : function() {
			$("input",$(this)).each(function(){
				$(this).val("");
			});
		}
	});
})(jQuery);
