window.countTotalChar=(form)-> 
   form_char_count = form.value.length
   remaining_char_count = 140 - form_char_count   
   document.getElementById("form_char_counter").innerHTML = remaining_char_count