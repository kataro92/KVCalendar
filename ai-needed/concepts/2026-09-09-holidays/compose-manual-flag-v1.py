from PIL import Image, ImageDraw, ImageFilter
import math, json
from pathlib import Path
root=Path(__file__).parent
base=Image.open(root/'05-quoc-khanh-base-v1.png').convert('RGBA')
W,H=base.size
S=3
layer=Image.new('RGBA',(W*S,H*S))
draw=ImageDraw.Draw(layer)
x,y,fw= W*.278,H*.165,W*.50
fh=fw*2/3
amp=fw*.033
def edge(u): return amp*math.sin(2*math.pi*u)
def pt(a,b): return (round(a*S),round(b*S))
# Pole: manually defined, vertical and seated behind the calendar header.
draw.rounded_rectangle([pt(x-8,y-29),pt(x+1,H*.385)],radius=3*S,fill='#8A785D')
draw.line([pt(x-5,y-24),pt(x-5,H*.384)],fill='#D2C5A8',width=2*S)
draw.ellipse([pt(x-12,y-37),pt(x+5,y-20)],fill='#BDA16E')
# One intact red cloth surface. Material dimensions are exactly 3:2.
# Only the outer cloth silhouette undulates; the star is never warped.
outline=[pt(x+fw*u,y+edge(u)) for u in [i/300 for i in range(301)]]
outline += [pt(x+fw*u,y+fh+edge(u)) for u in [i/300 for i in range(300,-1,-1)]]
draw.polygon(outline,fill='#DA251D')
# Low-amplitude manually defined folds; no pattern or generative texture.
for i in range(round(fw*S)):
    u=i/(fw*S)
    shade=0.93 + .065*math.cos(2*math.pi*u+.25)
    rgb=tuple(round(c*shade) for c in (218,37,29))
    xx=round(x*S)+i
    off=edge(u)
    draw.line([(xx,round((y+off)*S)),(xx,round((y+fh+off)*S))],fill=rgb,width=1)
draw.line(outline[:301],fill='#E64436',width=S)
# Upright exact regular pentagram outline, R = one fifth of flag length.
cx,cy=x+fw/2,y+fh/2
R=fw/5
r=R*math.sin(math.pi/10)/math.sin(3*math.pi/10)
star=[]
for i in range(10):
    a=-math.pi/2+i*math.pi/5
    rad=R if i%2==0 else r
    star.append((cx+rad*math.cos(a),cy+rad*math.sin(a)))
draw.polygon([pt(a,b) for a,b in star],fill='#FFFF00')
# Mild contact shadow, independent of emblem geometry.
alpha=layer.getchannel('A')
shadow=Image.new('RGBA',layer.size,(45,37,31,0))
shadow.putalpha(alpha.point(lambda v:round(v*.12)).filter(ImageFilter.GaussianBlur(6*S)))
shift=Image.new('RGBA',layer.size)
shift.alpha_composite(shadow,(5*S,7*S))
combined=base.resize(layer.size,Image.Resampling.LANCZOS)
combined.alpha_composite(shift)
combined.alpha_composite(layer)
combined.resize(base.size,Image.Resampling.LANCZOS).convert('RGB').save(root/'05-quoc-khanh-v1.png')
# Editable deterministic vector source of the same manually constructed flag.
top=' '.join(f'{x+fw*i/300:.3f},{y+edge(i/300):.3f}' for i in range(301))
bottom=' '.join(f'{x+fw*i/300:.3f},{y+fh+edge(i/300):.3f}' for i in range(300,-1,-1))
sp=' '.join(f'{a:.3f},{b:.3f}' for a,b in star)
svg=f'''<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">
<title>Quốc kỳ dựng thủ công — concept, chờ duyệt</title>
<rect x="{x-8}" y="{y-29}" width="9" height="{H*.385-y+29}" rx="3" fill="#8A785D"/>
<circle cx="{x-3.5}" cy="{y-28.5}" r="8.5" fill="#BDA16E"/>
<polygon points="{top} {bottom}" fill="#DA251D"/>
<polygon points="{sp}" fill="#FFFF00"/>
</svg>'''
(root/'quoc-ky-manual-v1.svg').write_text(svg,encoding='utf-8')
measure={'canvas':[W,H],'material_flag_width':fw,'material_flag_height':fh,'ratio':fw/fh,
'star_center':[cx,cy],'star_outer_radius':R,'star_inner_radius':r,'upright_tip':[cx,cy-R],
'outer_tip_count':5,'star_distortion':False,'cloth_edge_amplitude':amp,
'base_red':'#DA251D','star_yellow':'#FFFF00',
'color_note':'Working digital swatches selected manually; not a claim of legally mandated hex values.',
'review':'Geometry checked programmatically and visually by Codex; human reviewer pending.'}
assert abs(fw/fh-1.5)<1e-10
assert abs(R/fw-.2)<1e-10
assert len(star)==10
(root/'quoc-ky-measurements-v1.json').write_text(json.dumps(measure,ensure_ascii=False,indent=2),encoding='utf-8')
print(base.size)

