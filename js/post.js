function isMathMLSupported() {
  const testMath = document.createElement('math');
  testMath.innerHTML = '<mfrac><mi>a</mi><mi>b</mi></mfrac>';
  document.body.appendChild(testMath);
  
  const isSupported = testMath.offsetHeight > 1 && testMath.offsetWidth > 1;
  
  document.body.removeChild(testMath);
  
  return isSupported;
}

function mathMLToImage(mathElement) {
  const mathML = mathElement.outerHTML;
  
  const img = document.createElement('img');
  img.alt = mathElement.textContent || 'Mathematical formula';
  img.style.verticalAlign = 'middle';
  img.style.maxWidth = '100%';
  
  const encodedMathML = encodeURIComponent(mathML);
  img.src = `https://math.codecogs.com/svg.image?${encodedMathML}`;
  
  img.onerror = function() {
    const fallbackSpan = document.createElement('span');
    fallbackSpan.textContent = `[Math: ${mathElement.textContent}]`;
    fallbackSpan.style.fontStyle = 'italic';
    fallbackSpan.style.backgroundColor = '#f0f0f0';
    fallbackSpan.style.padding = '2px 4px';
    fallbackSpan.style.borderRadius = '3px';
    
    mathElement.parentNode.replaceChild(fallbackSpan, mathElement);
  };
  
  return img;
}

function replaceMathMLWithImages() {
  if (isMathMLSupported()) {
    return;
  }
  
  const mathElements = document.querySelectorAll('math');
  
  mathElements.forEach(mathElement => {
    const img = mathMLToImage(mathElement);
    mathElement.parentNode.replaceChild(img, mathElement);
  });
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', replaceMathMLWithImages);
} else {
  replaceMathMLWithImages();
}