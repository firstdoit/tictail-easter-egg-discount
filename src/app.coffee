console.log 'Hej!'

appStart = ->
  console.log 'Wow! Such Tic! Much Tail!'
  return

genericError = ->
  console.error 'Something went wrong'
  return

TT.native.init().done(appStart).fail(genericError)