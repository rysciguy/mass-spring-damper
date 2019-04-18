a = ptmass_H;
b = ptmass_H;
a.mass = 10;
b.mass = 5;

%some examples of usage
link1 = link_H;
a
a.addLink(link1);
a
b
b.addLink(link1);
b
link1
link1.addptmasses(a,b);
link1


b
link1.ptmassB.mass=6;
b
whos
a.GetSize();
b.GetSize();
link1.GetSize();