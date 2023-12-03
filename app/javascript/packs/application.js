import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap/dist/js/bootstrap.bundle'; 
import 'bootstrap';
import Flatpickr from 'flatpickr';
import 'flatpickr/dist/flatpickr.min.css';

document.addEventListener('DOMContentLoaded', function() {
    flatpickr('.datepicker', {
      // 任意のオプションを設定
    });
});

Rails.start()
ActiveStorage.start()