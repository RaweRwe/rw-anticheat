$(document).ready(function(){
    window.addEventListener('message', (event) => {
      if (event.data.type === 'checkscreenshot') {
        Tesseract.recognize(
          event.data.screenshoturl,
          'eng',
        ).then(({ data: { text } }) => {
            $.post('http:/${GetParentResourceName()}/menucheck', JSON.stringify({text}));
        });
      }
    });
  });