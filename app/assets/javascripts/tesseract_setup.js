var Tesseract = require('tesseract.js')

Tesseract.recognize('/assets/img/testwinelist.jpg')
.then(function(result){
    console.log(result)
})