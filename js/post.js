function isMathMLSupported() {
  const testMath = document.createElement('math');
  testMath.innerHTML = '<mfrac><mi>a</mi><mi>b</mi></mfrac>';
  document.body.appendChild(testMath);

  const isSupported = testMath.offsetHeight > 1 && testMath.offsetWidth > 1;

  document.body.removeChild(testMath);

  return isSupported;
}

function mathMLToFallback(mathElement) {
  const figure = mathElement.closest('figure');
  const noscript = figure?.querySelector('noscript');

  if (noscript && noscript.innerHTML.trim()) {
    const tempDiv = document.createElement('div');
    tempDiv.innerHTML = noscript.innerHTML;
    const fallbackElement = tempDiv.firstElementChild;

    if (fallbackElement) {
      return fallbackElement;
    }
  }

  const fallbackSpan = document.createElement('span');
  fallbackSpan.textContent = `[Math: ${mathElement.textContent}]`;
  fallbackSpan.style.fontStyle = 'italic';
  fallbackSpan.style.backgroundColor = '#f0f0f0';
  fallbackSpan.style.padding = '2px 4px';
  fallbackSpan.style.borderRadius = '3px';

  return fallbackSpan;
}

function replaceMathMLWithFallbacks() {
  if (isMathMLSupported()) {
    return;
  }

  const mathElements = document.querySelectorAll('math');

  mathElements.forEach(mathElement => {
    const fallback = mathMLToFallback(mathElement);
    mathElement.parentNode.replaceChild(fallback, mathElement);
  });
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', replaceMathMLWithFallbacks);
} else {
  replaceMathMLWithFallbacks();
}
