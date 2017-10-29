function order_by_occurrence(arr) {
  var counts = {};
  arr.forEach(function(value){
      if(!counts[value]) {
          counts[value] = 0;
      }
      counts[value]++;
  });

  return Object.keys(counts).sort(function(curKey,nextKey) {
      return counts[curKey] < counts[nextKey];
  });
}

function load_quagga(){
  console.log('loading quagga');
  console.log('navigator.mediaDevices', navigator.mediaDevices.enumerateDevices())
  if ($('#barcode-scanner').length > 0 && navigator.mediaDevices && typeof navigator.mediaDevices.getUserMedia === 'function') {

    var last_result = [];
    if (Quagga.initialized == undefined) {
      Quagga.onDetected(function(result) {
        var last_code = result.codeResult.code;
        last_result.push(last_code);
        if (last_result.length > 20) {
          code = order_by_occurrence(last_result)[0];
          last_result = [];
          Quagga.stop();
          $.ajax({
            type: "POST",
            url: '/wines/get_barcode',
            headers: { 
              'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') 
            },
            data: { upc: code },
            success: function (response) {
              console.log('succeeded request', response)
              window.location = response.url;
            },
            error: function(error) {
              console.log('request failed', error)
            }
          });
        }
      });
    }

    Quagga.init({
      inputStream : {
        name : "Live",
        type : "LiveStream",
        numOfWorkers: navigator.hardwareConcurrency,
        target: document.querySelector('#barcode-scanner')  
      },
      decoder: {
          readers : ['ean_reader','ean_8_reader','code_39_reader','code_39_vin_reader','codabar_reader','upc_reader','upc_e_reader']
      }
    },function(err) {
        if (err) { 
          console.log('ERROR')
          console.log(err); return 
        }
        Quagga.initialized = true;
        Quagga.start();
    });

  }
};
$(document).ready(load_quagga);