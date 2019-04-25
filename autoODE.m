function Sd = myODEfunc(t,S)
Sd = zeros(24, 1);
Sd(1) = S(2);
Sd(2) = (+ 1.000000 *((S(7)-S(1))- 1.000000 *((S(7)-S(1))/sqrt((S(7)-S(1))^2+(S(9)-S(3))^2+(S(11)-S(5))^2)))+ 2.000000*((S(8)-S(2))*(S(7)-S(1))+(S(10)-S(4))*(S(9)-S(3))+(S(12)-S(6))*(S(11)-S(5)))*(S(7)-S(1))/((S(7)-S(1))^2+(S(9)-S(3))^2+(S(11)-S(5))^2)+ 1.000000 *((S(13)-S(1))- 1.414214 *((S(13)-S(1))/sqrt((S(13)-S(1))^2+(S(15)-S(3))^2+(S(17)-S(5))^2)))+ 2.000000*((S(14)-S(2))*(S(13)-S(1))+(S(16)-S(4))*(S(15)-S(3))+(S(18)-S(6))*(S(17)-S(5)))*(S(13)-S(1))/((S(13)-S(1))^2+(S(15)-S(3))^2+(S(17)-S(5))^2)+ 1.000000 *((S(19)-S(1))- 1.000000 *((S(19)-S(1))/sqrt((S(19)-S(1))^2+(S(21)-S(3))^2+(S(23)-S(5))^2)))+ 2.000000*((S(20)-S(2))*(S(19)-S(1))+(S(22)-S(4))*(S(21)-S(3))+(S(24)-S(6))*(S(23)-S(5)))*(S(19)-S(1))/((S(19)-S(1))^2+(S(21)-S(3))^2+(S(23)-S(5))^2) + 0.000000)/1.000000;
Sd(3) = S(4);
Sd(4) = (+ 1.000000 *((S(9)-S(3))- 1.000000 *((S(9)-S(3))/sqrt((S(7)-S(1))^2+(S(9)-S(3))^2+(S(11)-S(5))^2)))+ 2.000000*((S(8)-S(2))*(S(7)-S(1))+(S(10)-S(4))*(S(9)-S(3))+(S(12)-S(6))*(S(11)-S(5)))*(S(9)-S(3))/((S(7)-S(1))^2+(S(9)-S(3))^2+(S(11)-S(5))^2)+ 1.000000 *((S(15)-S(3))- 1.414214 *((S(15)-S(3))/sqrt((S(13)-S(1))^2+(S(15)-S(3))^2+(S(17)-S(5))^2)))+ 2.000000*((S(14)-S(2))*(S(13)-S(1))+(S(16)-S(4))*(S(15)-S(3))+(S(18)-S(6))*(S(17)-S(5)))*(S(15)-S(3))/((S(13)-S(1))^2+(S(15)-S(3))^2+(S(17)-S(5))^2)+ 1.000000 *((S(21)-S(3))- 1.000000 *((S(21)-S(3))/sqrt((S(19)-S(1))^2+(S(21)-S(3))^2+(S(23)-S(5))^2)))+ 2.000000*((S(20)-S(2))*(S(19)-S(1))+(S(22)-S(4))*(S(21)-S(3))+(S(24)-S(6))*(S(23)-S(5)))*(S(21)-S(3))/((S(19)-S(1))^2+(S(21)-S(3))^2+(S(23)-S(5))^2) + 0.000000)/1.000000;
Sd(5) = S(6);
Sd(6) = (+ 1.000000 *((S(11)-S(5))- 1.000000 *((S(11)-S(5))/sqrt((S(7)-S(1))^2+(S(9)-S(3))^2+(S(11)-S(5))^2)))+ 2.000000*((S(8)-S(2))*(S(7)-S(1))+(S(10)-S(4))*(S(9)-S(3))+(S(12)-S(6))*(S(11)-S(5)))*(S(11)-S(5))/((S(7)-S(1))^2+(S(9)-S(3))^2+(S(11)-S(5))^2)+ 1.000000 *((S(17)-S(5))- 1.414214 *((S(17)-S(5))/sqrt((S(13)-S(1))^2+(S(15)-S(3))^2+(S(17)-S(5))^2)))+ 2.000000*((S(14)-S(2))*(S(13)-S(1))+(S(16)-S(4))*(S(15)-S(3))+(S(18)-S(6))*(S(17)-S(5)))*(S(17)-S(5))/((S(13)-S(1))^2+(S(15)-S(3))^2+(S(17)-S(5))^2)+ 1.000000 *((S(23)-S(5))- 1.000000 *((S(23)-S(5))/sqrt((S(19)-S(1))^2+(S(21)-S(3))^2+(S(23)-S(5))^2)))+ 2.000000*((S(20)-S(2))*(S(19)-S(1))+(S(22)-S(4))*(S(21)-S(3))+(S(24)-S(6))*(S(23)-S(5)))*(S(23)-S(5))/((S(19)-S(1))^2+(S(21)-S(3))^2+(S(23)-S(5))^2) + 0.000000)/1.000000;
Sd(7) = S(8);
Sd(8) = (+ 1.000000 *((S(1)-S(7))- 1.000000 *((S(1)-S(7))/sqrt((S(1)-S(7))^2+(S(3)-S(9))^2+(S(5)-S(11))^2)))+ 2.000000*((S(2)-S(8))*(S(1)-S(7))+(S(4)-S(10))*(S(3)-S(9))+(S(6)-S(12))*(S(5)-S(11)))*(S(1)-S(7))/((S(1)-S(7))^2+(S(3)-S(9))^2+(S(5)-S(11))^2)+ 1.000000 *((S(13)-S(7))- 1.000000 *((S(13)-S(7))/sqrt((S(13)-S(7))^2+(S(15)-S(9))^2+(S(17)-S(11))^2)))+ 2.000000*((S(14)-S(8))*(S(13)-S(7))+(S(16)-S(10))*(S(15)-S(9))+(S(18)-S(12))*(S(17)-S(11)))*(S(13)-S(7))/((S(13)-S(7))^2+(S(15)-S(9))^2+(S(17)-S(11))^2)+ 1.000000 *((S(19)-S(7))- 1.414214 *((S(19)-S(7))/sqrt((S(19)-S(7))^2+(S(21)-S(9))^2+(S(23)-S(11))^2)))+ 2.000000*((S(20)-S(8))*(S(19)-S(7))+(S(22)-S(10))*(S(21)-S(9))+(S(24)-S(12))*(S(23)-S(11)))*(S(19)-S(7))/((S(19)-S(7))^2+(S(21)-S(9))^2+(S(23)-S(11))^2) + 0.000000)/1.000000;
Sd(9) = S(10);
Sd(10) = (+ 1.000000 *((S(3)-S(9))- 1.000000 *((S(3)-S(9))/sqrt((S(1)-S(7))^2+(S(3)-S(9))^2+(S(5)-S(11))^2)))+ 2.000000*((S(2)-S(8))*(S(1)-S(7))+(S(4)-S(10))*(S(3)-S(9))+(S(6)-S(12))*(S(5)-S(11)))*(S(3)-S(9))/((S(1)-S(7))^2+(S(3)-S(9))^2+(S(5)-S(11))^2)+ 1.000000 *((S(15)-S(9))- 1.000000 *((S(15)-S(9))/sqrt((S(13)-S(7))^2+(S(15)-S(9))^2+(S(17)-S(11))^2)))+ 2.000000*((S(14)-S(8))*(S(13)-S(7))+(S(16)-S(10))*(S(15)-S(9))+(S(18)-S(12))*(S(17)-S(11)))*(S(15)-S(9))/((S(13)-S(7))^2+(S(15)-S(9))^2+(S(17)-S(11))^2)+ 1.000000 *((S(21)-S(9))- 1.414214 *((S(21)-S(9))/sqrt((S(19)-S(7))^2+(S(21)-S(9))^2+(S(23)-S(11))^2)))+ 2.000000*((S(20)-S(8))*(S(19)-S(7))+(S(22)-S(10))*(S(21)-S(9))+(S(24)-S(12))*(S(23)-S(11)))*(S(21)-S(9))/((S(19)-S(7))^2+(S(21)-S(9))^2+(S(23)-S(11))^2) + 0.000000)/1.000000;
Sd(11) = S(12);
Sd(12) = (+ 1.000000 *((S(5)-S(11))- 1.000000 *((S(5)-S(11))/sqrt((S(1)-S(7))^2+(S(3)-S(9))^2+(S(5)-S(11))^2)))+ 2.000000*((S(2)-S(8))*(S(1)-S(7))+(S(4)-S(10))*(S(3)-S(9))+(S(6)-S(12))*(S(5)-S(11)))*(S(5)-S(11))/((S(1)-S(7))^2+(S(3)-S(9))^2+(S(5)-S(11))^2)+ 1.000000 *((S(17)-S(11))- 1.000000 *((S(17)-S(11))/sqrt((S(13)-S(7))^2+(S(15)-S(9))^2+(S(17)-S(11))^2)))+ 2.000000*((S(14)-S(8))*(S(13)-S(7))+(S(16)-S(10))*(S(15)-S(9))+(S(18)-S(12))*(S(17)-S(11)))*(S(17)-S(11))/((S(13)-S(7))^2+(S(15)-S(9))^2+(S(17)-S(11))^2)+ 1.000000 *((S(23)-S(11))- 1.414214 *((S(23)-S(11))/sqrt((S(19)-S(7))^2+(S(21)-S(9))^2+(S(23)-S(11))^2)))+ 2.000000*((S(20)-S(8))*(S(19)-S(7))+(S(22)-S(10))*(S(21)-S(9))+(S(24)-S(12))*(S(23)-S(11)))*(S(23)-S(11))/((S(19)-S(7))^2+(S(21)-S(9))^2+(S(23)-S(11))^2) + 0.000000)/1.000000;
end
