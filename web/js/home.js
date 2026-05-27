const counters = document.querySelectorAll(".counter");

const startCounting = () => {
  counters.forEach(counter => {
    const target = +counter.getAttribute("data-target");
    let count = 0;
    const speed = target / 100;

    const updateCount = () => {
      count += speed;

      if (count < target) {
        counter.innerText = Math.floor(count);
        setTimeout(updateCount, 20);
      } else {
        counter.innerText = target + "+";
      }
    };

    updateCount();
  });
};

let started = false;

window.addEventListener("scroll", () => {
  const stats = document.querySelector(".stats");
  const top = stats.getBoundingClientRect().top;

  if (top < window.innerHeight && !started) {
    startCounting();
    started = true;
  }
});