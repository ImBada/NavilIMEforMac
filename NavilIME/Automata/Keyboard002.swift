//
//  Keyboard002.swift
//  automata
//
//  Created by Manwoo Yi on 9/30/22.
//

import Foundation

class Keyboard002 : Keyboard {
    override init() {
        super.init()
        
        self.name = "두벌식"
        self.id = 2
        
        // 초성 레이아웃
        self.chosung_layout = [
            "Q":Chosung.SsBiep,
            "W":Chosung.SsJiek,
            "E":Chosung.SsDigek,
            "R":Chosung.SsGiyuk,
            "T":Chosung.SsSiot,
            
            "q":Chosung.Biep,
            "w":Chosung.Jiek,
            "e":Chosung.Digek,
            "r":Chosung.Giyuk,
            "t":Chosung.Siot,
            
            "a":Chosung.Miem,
            "s":Chosung.Nien,
            "d":Chosung.Yieng,
            "f":Chosung.Riel,
            "g":Chosung.Hiek,
            
            "z":Chosung.Kiyuk,
            "x":Chosung.Tigek,
            "c":Chosung.Chiek,
            "v":Chosung.Piep
        ]
        
        // 중성 레이아웃
        self.jungsung_layout = [
            "O":Jungsung.Yae,
            "P":Jungsung.Ye,
            
            "oo":Jungsung.Yae,
            "pp":Jungsung.Ye,
            
            "y":Jungsung.Yo,
            "u":Jungsung.Yeo,
            "i":Jungsung.Ya,
            "o":Jungsung.Ae,
            "p":Jungsung.E,
            
            "h":Jungsung.O,
            "j":Jungsung.Eo,
            "k":Jungsung.A,
            "l":Jungsung.I,
            
            "b":Jungsung.Yu,
            "n":Jungsung.U,
            "m":Jungsung.Eu,
            
            // 이중 모음 (ㅘ,ㅙ,ㅝ,ㅞ,ㅚ,ㅟ,ㅢ)
            "hk":Jungsung.Wa,
            "ho":Jungsung.Wae,
            "nj":Jungsung.Weo,
            "np":Jungsung.We,
            "hl":Jungsung.Oe,
            "nl":Jungsung.Wi,
            "ml":Jungsung.Yi
        ]
        
        // 종성 레이아웃
        self.jongsung_layout = [
            "r":Jongsung.Kiyeok,
            "R":Jongsung.Ssangkiyeok,
            "rt":Jongsung.Kiyeoksios,
            "s":Jongsung.Nieun,
            "sw":Jongsung.Nieuncieuc,
            "sg":Jongsung.Nieunhieuh,
            "e":Jongsung.Tikeut,
            "f":Jongsung.Rieul,
            "fr":Jongsung.Rieulkiyeok,
            "fa":Jongsung.Rieulmieum,
            "fq":Jongsung.Rieulpieup,
            "ft":Jongsung.Rieulsios,
            "fx":Jongsung.Rieulthieuth,
            "fv":Jongsung.Rieulphieuph,
            "fg":Jongsung.Rieulhieuh,
            "a":Jongsung.Mieum,
            "q":Jongsung.Pieup,
            "qt":Jongsung.Pieupsios,
            "t":Jongsung.Sios,
            "T":Jongsung.Ssangsios,
            "d":Jongsung.Ieung,
            "w":Jongsung.Cieuc,
            "c":Jongsung.Chieuch,
            "z":Jongsung.Khieukh,
            "x":Jongsung.Thieuth,
            "v":Jongsung.Phieuph,
            "g":Jongsung.Hieuh
        ]
    }
    
    override func chosung_proc(comp: inout Composition, ch: String) -> Bool {
        // 기존 입력에 초성이 있고 중성도 있음
        if comp.chosung != "" && comp.jungsung != "" {
            // 초성 테이블에서 더이상 검색하지 않음
            return false
        }
        let chokey:String = comp.chosung + ch
        return self.chosung_layout[chokey] != nil ? true : false
    }
    
    override func jungsung_proc(comp: inout Composition, ch: String) -> Bool {
        // 입력이 중성이 아니면 일단 넘어감
        if self.jungsung_layout[ch] == nil {
            return false
        }
        // 종성이 있고
        if comp.jongsung != "" {
            // 종성의 마지막 글자 (종성은 겹받침이 가능하므로 최대 두 글자)
            var jong_arr = Array(comp.jongsung)
            let jong_last = jong_arr.removeLast()
            // 종성이 초성 테이블에 있으면 (앞글자의 종성이 다음 글자의 초성으로 가는 상황.. 도깨비불 현상)
            if self.chosung_layout[String(jong_last)] != nil {
                // 종성 마지막 글자를 없애고 조합 완료를 표시하고 더이상 검색하지 않음
                comp.jongsung = String(jong_arr)
                comp.done = true
                return false
            }
        }
        // 다른 예외 없이 중성이 입력되었단 뜻
        // 그러므로 이중 모음을 찾아봄
        let jungkey:String = comp.jungsung + ch
        return self.jungsung_layout[jungkey] != nil ? true : false
    }
    
    override func jongsung_proc(comp: inout Composition, ch: String) -> Bool {
        // 중성이 없으면 검색하지 않음
        if comp.jungsung == "" {
            return false
        }
        let jongkey:String = comp.jongsung + ch
        return self.jongsung_layout[jongkey] != nil ? true : false
    }
}