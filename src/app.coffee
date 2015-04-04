appStart = ->
  console.log 'Wow! Such Tic! Much Tail!'

genericError = ->
  console.error 'Something went wrong'

TT.native.init().done(appStart).fail(genericError)