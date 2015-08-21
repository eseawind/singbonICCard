/**
 * @author 郝威
 */

(function($) {
	$.fn.extend({
		clearForm : function() {
			$("input:not(:radio):not(:checkbox)",$(this)).each(function(){
				$(this).val("");
			});
		}
	});
})(jQuery);
