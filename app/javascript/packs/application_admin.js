import Rails from '@rails/ujs'
import Turbolinks from 'turbolinks'
import * as ActiveStorage from '@rails/activestorage'
import 'channels'
require('jquery')
import 'cocoon'
import 'bootstrap'
import 'chartkick/chart.js'
import 'chartkick/highcharts'

Rails.start()
Turbolinks.start()
ActiveStorage.start()
