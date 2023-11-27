function kolo () {
    while (true) {
        if (TA == 1) {
            x += 1
            emptyX()
            TA = 0
        } else if (TB == 1) {
            y += 1
            emptyY()
            TB = 0
        } else if (TApB == 1) {
            if (y == 1) {
                pole1[x - 1] = hrac
                led.plotBrightness(x, y, hrac * 50)
                TApB = 0
                break;
            } else if (y == 2) {
                pole2[x - 1] = hrac
                led.plotBrightness(x, y, hrac * 50)
                TApB = 0
                break;
            } else if (y == 3) {
                pole3[x - 1] = hrac
                led.plotBrightness(x, y, hrac * 50)
                TApB = 0
                break;
            }
        }
        led.plotBrightness(x, y, hrac * 50)
        while (TA == 0 && (TB == 0 && TApB == 0)) {
            basic.pause(50)
        }
        led.unplot(x, y)
    }
}
function hra () {
    while (true) {
        basic.showLeds(`
            # # # # #
            # . . . #
            # . . . #
            # . . . #
            # # # # #
            `)
        pole1 = [0, 0, 0]
        pole2 = [0, 0, 0]
        pole3 = [0, 0, 0]
        hrac = 4
        PocKol = 0
        while (PocKol <= 8) {
            x = 1
            y = 1
            emptyY()
            if (hrac == 1) {
                hrac = 4
            } else if (hrac == 4) {
                hrac = 1
            }
            kolo()
            if (PocKol >= 4) {
                EndGame()
            }
            PocKol += 1
        }
        if (PocKol == 9) {
            basic.showString(" DRAW")
        }
    }
}
input.onButtonPressed(Button.A, function () {
    TA = 1
})
function emptyX () {
    ScitanieRiadka()
    if (riadok == 2 || (riadok == 5 || riadok == 8)) {
        x = 1
        if (y == 3) {
            y = 1
        } else {
            y += 1
        }
    }
    while (true) {
        if (y == 1) {
            if (pole1[x - 1] != 0) {
                x += 1
            } else {
                break;
            }
        } else if (y == 2) {
            if (pole2[x - 1] != 0) {
                x += 1
            } else {
                break;
            }
        } else if (y == 3) {
            if (pole3[x - 1] != 0) {
                x += 1
            } else {
                break;
            }
        }
        if (x > 3) {
            x = 1
            ScitanieRiadka()
            if (riadok % 3 == 0 && riadok > 0) {
                if (y == 3) {
                    y = 1
                } else {
                    y += 1
                }
            }
        }
    }
}
function emptyY () {
    if (TB == 1) {
        ScitanieStlpca()
        if (stlpec == 2 || (stlpec == 5 || stlpec == 8)) {
            y = 1
            if (x == 3) {
                x = 1
            } else {
                x += 1
            }
        }
    }
    while (true) {
        if (y == 1) {
            if (pole1[x - 1] != 0) {
                y += 1
            } else {
                break;
            }
        } else if (y == 2) {
            if (pole2[x - 1] != 0) {
                y += 1
            } else {
                break;
            }
        } else if (y == 3) {
            if (pole3[x - 1] != 0) {
                y += 1
            } else {
                break;
            }
        } else if (y > 3) {
            y = 1
            if (pole1[x - 1] != 0 && (pole2[x - 1] != 0 && pole3[x - 1] != 0)) {
                if (x == 3) {
                    x = 1
                } else {
                    x += 1
                }
            }
        }
    }
}
input.onButtonPressed(Button.AB, function () {
    TApB = 1
})
function ScitanieDiagonal () {
    diagonala1 = pole1[0] + (pole2[1] + pole3[2])
    diagonala2 = pole1[2] + (pole2[1] + pole3[0])
}
input.onButtonPressed(Button.B, function () {
    TB = 1
})
function ScitanieRiadka () {
    riadok = 0
    if (y == 1) {
        for (let _index = 0; _index <= 2; _index++) {
            riadok += pole1[_index]
        }
    } else if (y == 2) {
        for (let _index2 = 0; _index2 <= 2; _index2++) {
            riadok += pole2[_index2]
        }
    } else if (y == 3) {
        for (let _index3 = 0; _index3 <= 2; _index3++) {
            riadok += pole3[_index3]
        }
    }
}
function ScitanieStlpca () {
    stlpec = pole1[x - 1] + pole2[x - 1] + pole3[x - 1]
}
function EndGame () {
    ScitanieRiadka()
    if (riadok == 3) {
        basic.showString(" P1 WIN")
        PocKol = 10
    } else if (riadok == 12) {
        basic.showString(" P2 WIN")
        PocKol = 10
    }
    ScitanieStlpca()
    if (stlpec == 3) {
        basic.showString(" P1 WIN")
        PocKol = 10
    } else if (stlpec == 12) {
        basic.showString(" P2 WIN")
        PocKol = 10
    }
    ScitanieDiagonal()
    if (diagonala1 == 3 || diagonala2 == 3) {
        basic.showString(" P1 WIN")
        PocKol = 10
    } else if (diagonala1 == 12 || diagonala2 == 12) {
        basic.showString(" P2 WIN")
        PocKol = 10
    }
}
let diagonala2 = 0
let diagonala1 = 0
let stlpec = 0
let riadok = 0
let PocKol = 0
let pole3: number[] = []
let pole2: number[] = []
let hrac = 0
let pole1: number[] = []
let y = 0
let x = 0
let TApB = 0
let TB = 0
let TA = 0
hra()
