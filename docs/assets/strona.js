const $=(s,c=document)=>c.querySelector(s);const $$=(s,c=document)=>[...c.querySelectorAll(s)];
const menu=$('.menu'),links=$('.nav-links');if(menu)menu.addEventListener('click',()=>{links.classList.toggle('otwarte');menu.setAttribute('aria-expanded',links.classList.contains('otwarte'))});
$$('.nav-links a').forEach(a=>a.addEventListener('click',()=>links?.classList.remove('otwarte')));
const io=new IntersectionObserver(es=>es.forEach(e=>{if(e.isIntersecting){e.target.classList.add('widoczny');io.unobserve(e.target)}}),{threshold:.12});$$('.reveal').forEach(el=>io.observe(el));
$$('[data-copy]').forEach(btn=>btn.addEventListener('click',async()=>{const code=$(btn.dataset.copy);if(!code)return;await navigator.clipboard.writeText(code.innerText.trim());const old=btn.textContent;btn.textContent='Skopiowano';setTimeout(()=>btn.textContent=old,1600)}));
const zredukowany=matchMedia('(prefers-reduced-motion: reduce)').matches;
const liczniki=$$('.stat-num[data-target]');
if(liczniki.length){const io2=new IntersectionObserver(es=>es.forEach(e=>{if(!e.isIntersecting)return;io2.unobserve(e.target);const el=e.target,cel=+el.dataset.target,sufiks=el.dataset.suffix||'';if(zredukowany){el.textContent=cel+sufiks;return}const start=performance.now(),czas=1100;const krok=t=>{const p=Math.min(1,(t-start)/czas),z=1-Math.pow(1-p,3);el.textContent=Math.round(cel*z)+sufiks;if(p<1)requestAnimationFrame(krok);else el.classList.add('policzone')};requestAnimationFrame(krok)}),{threshold:.4});liczniki.forEach(el=>io2.observe(el))}
