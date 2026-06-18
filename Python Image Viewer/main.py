from PIL import Image
import glob

WIDTH = 160
HEIGHT = 120

frames = []

for filename in sorted(glob.glob("frame_*.txt")):

    img = Image.new("RGB", (WIDTH, HEIGHT))
    pixels = img.load()

    with open(filename) as f:
        data = [int(line.strip(), 16) for line in f]

    for y in range(HEIGHT):
        for x in range(WIDTH):
            p = data[y * WIDTH + x]

            r = ((p >> 8) & 0xF) * 17
            g = ((p >> 4) & 0xF) * 17
            b = (p & 0xF) * 17

            pixels[x, y] = (r, g, b)

    # Scale framebuffer image to VGA size
    img = img.resize((640, 480), Image.NEAREST)

    frames.append(img)

# Save animation
frames[0].save(
    "animation.gif",
    save_all=True,
    append_images=frames[1:],
    duration=100,   # milliseconds per frame
    loop=0
)

print(f"Generated GIF with {len(frames)} frames")