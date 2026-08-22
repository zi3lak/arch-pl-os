const $=(s,c=document)=>c.querySelector(s);const $$=(s,c=document)=>[...c.querySelectorAll(s)];
const menu=$('.menu'),links=$('.nav-links');if(menu)menu.addEventListener('click',()=>{links.classList.toggle('otwarte');menu.setAttribute('aria-expanded',links.classList.contains('otwarte'))});
$$('.nav-links a').forEach(a=>a.addEventListener('click',()=>links?.classList.remove('otwarte')));
const io=new IntersectionObserver(es=>es.forEach(e=>{if(e.isIntersecting){e.target.classList.add('widoczny');io.unobserve(e.target)}}),{threshold:.12});$$('.reveal').forEach(el=>io.observe(el));
$$('[data-copy]').forEach(btn=>btn.addEventListener('click',async()=>{const code=$(btn.dataset.copy);if(!code)return;await navigator.clipboard.writeText(code.innerText.trim());const old=btn.textContent;btn.textContent='Skopiowano';setTimeout(()=>btn.textContent=old,1600)}));
