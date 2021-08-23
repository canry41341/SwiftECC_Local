//
//  BlueTest.swift
//  SwiftECCTests
//
//  Created by Leif Ibsen on 19/02/2020.
//

import XCTest

/*
 Test compatibility with IBM's BlueECC product.
 BlueECC supports the three curves prime256v1, secp384r1 and secp521r1
 corresponding to the AEC domains EC256r1, EC384r1 and EC521r1
 */

class BlueTest: XCTestCase {

    // Keys used by BlueECC
    
    let pub256r1 =
    """
    -----BEGIN PUBLIC KEY-----
    MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEfaPQIm1a5H3ReCRI3+bVXHhQLGTuO0htD71gaNZ5
    xIJo4OjcPWZh70bm8e+noMJzcOJPdTfzbfhxwhGGNOAfxw==
    -----END PUBLIC KEY-----
    """

    let priv256r1 =
    """
    -----BEGIN EC PRIVATE KEY-----
    MHcCAQEEIM7uPVSTTQII5EAn6wjra4M1qJl5d8CowdQlbF7RAZ4XoAoGCCqGSM49AwEHoUQDQgAE
    faPQIm1a5H3ReCRI3+bVXHhQLGTuO0htD71gaNZ5xIJo4OjcPWZh70bm8e+noMJzcOJPdTfzbfhx
    whGGNOAfxw==
    -----END EC PRIVATE KEY-----
    """

    let pub384r1 =
    """
    -----BEGIN PUBLIC KEY-----
    MHYwEAYHKoZIzj0CAQYFK4EEACIDYgAENOwCoSuaECUOL26wojZwf66L26/6tJjqRUVWEVvs1yoV
    I0hxYYdBBzRSMgeYeN4fbiJ6JiJDeLUwjOG0wd81LPRSpqrIyJZSe281ucAYehev8LlK0Wy+h4N0
    Rrw8kByK
    -----END PUBLIC KEY-----
    """

    let priv384r1 =
    """
    -----BEGIN EC PRIVATE KEY-----
    MIGkAgEBBDDi1+BU2xNPXEvciqtBclfaWoJ83Ocx7Hs8tT6puFCYGdvBazUVBrP7/ZAjwU4ZHVKg
    BwYFK4EEACKhZANiAAQ07AKhK5oQJQ4vbrCiNnB/rovbr/q0mOpFRVYRW+zXKhUjSHFhh0EHNFIy
    B5h43h9uInomIkN4tTCM4bTB3zUs9FKmqsjIllJ7bzW5wBh6F6/wuUrRbL6Hg3RGvDyQHIo=
    -----END EC PRIVATE KEY-----
    """

    let pub521r1 =
    """
    -----BEGIN PUBLIC KEY-----
    MIGbMBAGByqGSM49AgEGBSuBBAAjA4GGAAQA5g497X177m6TAgZA4sK9QitomnUkUgSdSIdM07pZ
    f4pwB1qdw1pt5C9N5TVp+V/ox057EWQeyNVW2NHs7pNYlZgAbD3klynuvXTKLhLkwo2iKlBtGT8Y
    KyzaInOEvnrqsFXN6OkF+CWzFcuYagD4wD2QasKaONTLhwnmWMSrdxTmT8E=
    -----END PUBLIC KEY-----
    """

    let priv521r1 =
    """
    -----BEGIN EC PRIVATE KEY-----
    MIHcAgEBBEIBmrX72oofcDCHf3IWmlM1Cb4MzK4rTubdEf8UmY08EuUAFQVbYc90k1yeGCQTTDr3
    qiQu3XH43rjjiPGl/JhGzDigBwYFK4EEACOhgYkDgYYABADmDj3tfXvubpMCBkDiwr1CK2iadSRS
    BJ1Ih0zTull/inAHWp3DWm3kL03lNWn5X+jHTnsRZB7I1VbY0ezuk1iVmABsPeSXKe69dMouEuTC
    jaIqUG0ZPxgrLNoic4S+euqwVc3o6QX4JbMVy5hqAPjAPZBqwpo41MuHCeZYxKt3FOZPwQ==
    -----END EC PRIVATE KEY-----
    """

    let empty = ""

    // empty encrypted by BlueECC
    
    let encryptedEmpty_256: Bytes =
    [ 4, 111, 227, 171, 136, 155, 111, 144, 214, 134, 136, 15, 161, 93, 184, 149
    , 86, 210, 33, 111, 232, 57, 111, 8, 217, 76, 119, 109, 188, 230, 37, 157
    , 87, 35, 79, 48, 185, 252, 84, 197, 221, 215, 172, 119, 38, 199, 24, 66
    , 169, 32, 113, 148, 178, 71, 21, 132, 46, 173, 139, 189, 170, 132, 241, 8
    , 96, 5, 177, 206, 176, 189, 26, 197, 4, 181, 81, 21, 243, 140, 185, 39
    , 186]
    let encryptedEmpty_384: Bytes =
    [ 4, 124, 88, 84, 64, 119, 149, 207, 185, 75, 163, 38, 179, 79, 245, 1
    , 115, 131, 251, 246, 112, 224, 42, 155, 65, 6, 224, 236, 99, 223, 204, 54
    , 70, 250, 131, 107, 94, 224, 86, 22, 65, 58, 144, 61, 68, 203, 221, 21
    , 56, 132, 146, 32, 150, 77, 104, 48, 56, 139, 143, 86, 200, 35, 114, 27
    , 226, 29, 114, 63, 102, 41, 186, 112, 116, 207, 160, 3, 149, 136, 144, 121
    , 162, 213, 82, 239, 159, 223, 74, 84, 67, 240, 177, 88, 107, 1, 224, 236
    , 252, 60, 172, 246, 223, 251, 239, 241, 9, 41, 70, 174, 100, 171, 239, 21
    , 69]
    let encryptedEmpty_521: Bytes =
    [ 4, 0, 76, 208, 170, 202, 31, 28, 178, 171, 199, 69, 135, 87, 19, 132
    , 40, 6, 64, 69, 170, 120, 196, 172, 33, 169, 68, 225, 136, 250, 99, 14
    , 98, 231, 246, 152, 134, 169, 92, 78, 195, 139, 246, 240, 23, 100, 45, 87
    , 136, 86, 101, 81, 87, 70, 186, 113, 178, 189, 76, 46, 61, 155, 168, 35
    , 25, 7, 82, 0, 166, 106, 230, 131, 13, 85, 188, 213, 76, 106, 184, 75
    , 204, 88, 229, 110, 180, 19, 32, 171, 185, 196, 73, 146, 191, 35, 18, 137
    , 56, 200, 28, 76, 10, 24, 74, 185, 2, 43, 241, 130, 71, 43, 73, 206
    , 4, 206, 43, 3, 19, 223, 202, 213, 216, 140, 106, 226, 254, 214, 139, 37
    , 72, 54, 225, 97, 239, 130, 1, 148, 107, 245, 255, 178, 124, 234, 233, 112
    , 47, 4, 117, 16, 10]
    
    // empty signed by BlueECC
    
    let emptyR256: Bytes =
    [ 29, 36, 35, 130, 153, 40, 81, 112, 56, 235, 157, 220, 4, 78, 9, 241
    , 72, 239, 246, 118, 193, 247, 116, 202, 56, 143, 33, 126, 111, 48, 156, 95]
    let emptyS256: Bytes =
    [ 104, 243, 221, 213, 155, 120, 96, 246, 214, 241, 1, 247, 220, 78, 80, 143
    , 67, 71, 62, 97, 27, 0, 188, 73, 132, 56, 198, 3, 86, 134, 23, 117]
    let emptyR384: Bytes =
    [ 254, 26, 223, 63, 247, 196, 135, 150, 192, 229, 37, 130, 49, 223, 137, 224
    , 14, 153, 143, 0, 107, 209, 225, 89, 145, 31, 190, 101, 246, 29, 248, 84
    , 249, 114, 250, 235, 72, 124, 164, 180, 119, 20, 102, 110, 107, 76, 129, 164]
    let emptyS384: Bytes =
    [ 124, 231, 84, 119, 145, 179, 217, 37, 254, 255, 110, 193, 12, 112, 84, 242
    , 239, 178, 239, 170, 95, 243, 130, 25, 49, 6, 1, 78, 106, 29, 188, 57
    , 77, 222, 235, 237, 51, 121, 195, 82, 95, 94, 214, 145, 120, 158, 254, 128]
    let emptyR521: Bytes =
    [ 1, 196, 0, 34, 177, 77, 249, 123, 186, 86, 209, 106, 177, 176, 236, 194
    , 115, 100, 69, 88, 47, 109, 40, 104, 84, 230, 253, 178, 234, 253, 67, 37
    , 3, 29, 141, 121, 38, 134, 163, 63, 217, 164, 49, 57, 18, 122, 224, 172
    , 193, 107, 61, 251, 38, 70, 108, 58, 2, 177, 65, 57, 159, 2, 82, 35, 115, 253]
    let emptyS521: Bytes =
    [ 1, 214, 174, 155, 25, 105, 127, 53, 61, 201, 208, 5, 236, 134, 131, 13
    , 223, 128, 116, 97, 117, 155, 202, 27, 29, 13, 54, 24, 108, 132, 136, 2
    , 161, 96, 100, 236, 167, 188, 208, 203, 205, 14, 35, 173, 153, 129, 53, 140
    , 29, 49, 57, 90, 16, 250, 176, 175, 115, 161, 83, 65, 169, 207, 41, 101, 48, 53]

    let fox = "The quick brown fox jumps over the lazy dog!"

    // fox encrypted by BlueECC
    
    let encryptedFox_256: Bytes =
    [ 4, 251, 74, 69, 188, 199, 125, 200, 128, 14, 235, 37, 97, 55, 47, 193
    , 25, 104, 9, 182, 69, 138, 85, 237, 23, 125, 7, 6, 11, 171, 97, 146
    , 130, 62, 2, 24, 0, 158, 42, 89, 222, 142, 100, 55, 192, 83, 155, 194
    , 210, 45, 76, 92, 150, 17, 134, 246, 26, 207, 145, 41, 78, 191, 99, 42
    , 200, 127, 115, 154, 47, 252, 73, 19, 194, 176, 44, 85, 253, 66, 145, 24
    , 97, 61, 24, 125, 105, 87, 117, 81, 183, 57, 96, 138, 26, 196, 87, 17
    , 103, 212, 149, 8, 23, 204, 131, 38, 134, 99, 74, 148, 132, 37, 76, 173
    , 191, 60, 102, 21, 245, 97, 78, 145, 196, 174, 94, 172, 67]
    let encryptedFox_384: Bytes =
    [ 4, 164, 175, 233, 239, 30, 214, 120, 111, 123, 158, 193, 99, 55, 17, 77
    , 51, 139, 51, 142, 206, 229, 129, 251, 68, 167, 28, 165, 144, 108, 77, 37
    , 248, 21, 65, 102, 164, 170, 142, 113, 226, 41, 245, 155, 164, 166, 99, 156
    , 253, 103, 245, 114, 189, 69, 199, 219, 76, 33, 236, 149, 104, 6, 212, 30
    , 202, 72, 225, 76, 70, 250, 123, 186, 249, 125, 104, 145, 207, 200, 47, 202
    , 91, 137, 172, 168, 148, 103, 251, 91, 27, 171, 185, 101, 186, 207, 31, 198
    , 216, 213, 43, 4, 119, 31, 226, 211, 162, 127, 103, 165, 210, 67, 62, 220
    , 56, 155, 163, 230, 118, 217, 15, 121, 150, 34, 187, 184, 128, 190, 240, 93
    , 90, 210, 117, 37, 150, 209, 173, 3, 231, 24, 0, 158, 143, 98, 15, 185
    , 117, 248, 136, 210, 187, 71, 103, 121, 149, 211, 234, 51, 189]
    let encryptedFox_521: Bytes =
    [ 4, 1, 240, 247, 88, 149, 15, 80, 91, 107, 156, 152, 125, 97, 76, 190
    , 253, 88, 165, 150, 28, 191, 192, 57, 128, 240, 247, 122, 97, 217, 140, 179
    , 114, 201, 32, 230, 161, 156, 61, 156, 204, 212, 19, 233, 203, 55, 56, 66
    , 233, 65, 239, 145, 19, 20, 6, 111, 100, 213, 26, 183, 86, 93, 97, 212
    , 248, 132, 92, 1, 192, 21, 108, 124, 188, 196, 229, 90, 69, 95, 163, 156
    , 81, 130, 108, 30, 179, 167, 35, 0, 25, 183, 28, 225, 179, 47, 57, 215
    , 236, 6, 222, 207, 210, 108, 213, 24, 204, 143, 223, 185, 208, 248, 198, 48
    , 85, 168, 94, 50, 50, 10, 237, 22, 181, 168, 82, 156, 21, 76, 177, 176
    , 43, 25, 50, 83, 123, 2, 189, 198, 142, 192, 92, 137, 196, 98, 72, 237
    , 195, 225, 167, 12, 74, 232, 73, 164, 214, 90, 248, 139, 3, 107, 129, 33
    , 183, 208, 71, 102, 132, 69, 198, 250, 106, 129, 177, 13, 195, 191, 196, 174
    , 53, 51, 167, 230, 39, 164, 186, 5, 26, 54, 35, 5, 68, 49, 210, 224, 79]

    // fox signed by BlueECC

    let foxR256: Bytes =
    [ 128, 219, 172, 165, 204, 104, 2, 140, 63, 191, 181, 226, 204, 164, 163, 14
    , 233, 127, 185, 252, 73, 179, 16, 149, 77, 12, 212, 62, 22, 225, 171, 184]
    let foxS256: Bytes =
    [ 121, 240, 132, 182, 44, 19, 42, 81, 197, 72, 162, 141, 123, 216, 155, 236
    , 193, 105, 214, 163, 102, 205, 201, 100, 221, 114, 34, 114, 71, 65, 100, 225]
    let foxR384: Bytes =
    [ 223, 77, 221, 20, 34, 89, 186, 30, 106, 127, 11, 185, 184, 101, 100, 205
    , 250, 119, 132, 122, 199, 165, 174, 239, 83, 229, 191, 97, 69, 180, 247, 98
    , 93, 17, 117, 221, 7, 29, 242, 144, 104, 5, 205, 95, 178, 210, 36, 133]
    let foxS384: Bytes =
    [ 240, 226, 202, 16, 30, 49, 93, 152, 173, 169, 236, 42, 160, 184, 156, 223
    , 48, 237, 237, 58, 42, 206, 118, 7, 159, 98, 49, 202, 114, 198, 152, 107
    , 199, 174, 164, 66, 156, 196, 41, 8, 156, 85, 9, 20, 95, 24, 50, 11]
    let foxR521: Bytes =
    [ 1, 80, 148, 11, 229, 177, 92, 224, 187, 33, 230, 138, 26, 178, 28, 120
    , 97, 29, 140, 37, 217, 103, 20, 112, 230, 28, 131, 237, 29, 171, 237, 161
    , 25, 184, 245, 133, 154, 154, 141, 227, 223, 61, 62, 20, 155, 31, 147, 194
    , 86, 218, 6, 191, 103, 152, 87, 11, 12, 220, 180, 47, 81, 24, 236, 71, 137, 218]
    let foxS521: Bytes =
    [ 1, 169, 15, 111, 17, 249, 249, 157, 223, 145, 108, 232, 86, 230, 91, 212
    , 120, 153, 109, 200, 93, 54, 132, 150, 107, 128, 217, 111, 103, 113, 46, 52
    , 5, 118, 192, 7, 188, 109, 177, 171, 144, 181, 36, 134, 213, 216, 162, 28
    , 29, 226, 7, 113, 173, 138, 254, 116, 65, 35, 207, 28, 159, 238, 228, 1, 188, 57]

    let a100 = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

    // a100 encrypted by BlueECC
    
let encryptedA100_256: Bytes =
    [ 4, 50, 45, 153, 144, 228, 219, 14, 72, 155, 107, 194, 193, 73, 137, 120
    , 23, 103, 40, 165, 134, 95, 86, 144, 250, 100, 25, 14, 207, 251, 54, 17
    , 195, 7, 217, 224, 136, 11, 11, 148, 89, 47, 218, 9, 175, 164, 78, 43
    , 18, 34, 155, 201, 90, 238, 24, 122, 207, 255, 239, 197, 31, 4, 171, 148
    , 238, 216, 221, 142, 169, 9, 190, 26, 53, 16, 68, 238, 166, 179, 73, 177
    , 177, 206, 165, 105, 211, 90, 48, 224, 62, 203, 176, 45, 129, 55, 109, 52
    , 162, 193, 245, 236, 210, 187, 190, 221, 93, 206, 36, 218, 27, 244, 16, 173
    , 251, 41, 168, 0, 27, 226, 97, 58, 179, 175, 216, 119, 25, 70, 155, 50
    , 0, 131, 223, 144, 119, 205, 227, 73, 27, 111, 98, 82, 229, 31, 61, 137
    , 75, 39, 210, 194, 207, 31, 183, 54, 80, 116, 162, 2, 198, 252, 170, 215
    , 75, 161, 14, 112, 32, 104, 175, 133, 138, 243, 159, 195, 174, 97, 166, 96
    , 151, 13, 41, 206, 220]
let encryptedA100_384: Bytes =
    [ 4, 16, 134, 9, 105, 73, 114, 106, 96, 151, 129, 7, 144, 102, 146, 46
    , 247, 109, 175, 125, 31, 169, 38, 95, 17, 50, 153, 246, 171, 136, 114, 126
    , 72, 56, 170, 246, 244, 54, 155, 245, 46, 107, 52, 113, 38, 113, 186, 228
    , 235, 13, 19, 148, 221, 80, 252, 177, 59, 57, 199, 162, 239, 222, 50, 93
    , 200, 233, 211, 181, 1, 193, 232, 118, 175, 250, 92, 0, 16, 208, 93, 112
    , 51, 172, 18, 54, 222, 26, 96, 134, 30, 236, 102, 20, 146, 32, 157, 161
    , 69, 89, 43, 147, 49, 224, 82, 202, 139, 30, 32, 252, 16, 190, 113, 141
    , 235, 119, 190, 204, 177, 134, 69, 37, 240, 53, 166, 20, 150, 79, 207, 109
    , 189, 129, 145, 254, 91, 191, 31, 206, 167, 36, 64, 167, 233, 116, 242, 28
    , 180, 247, 111, 211, 103, 109, 69, 196, 177, 235, 161, 138, 31, 195, 60, 51
    , 66, 203, 59, 95, 65, 238, 36, 3, 158, 243, 53, 98, 59, 101, 217, 138
    , 102, 38, 168, 110, 168, 92, 101, 19, 205, 182, 214, 129, 209, 13, 197, 57
    , 32, 88, 35, 97, 123, 106, 141, 99, 8, 110, 2, 116, 106, 120, 182, 213
    , 198, 241, 61, 62, 165]
let encryptedA100_521: Bytes =
    [ 4, 1, 223, 247, 214, 75, 142, 25, 33, 122, 31, 235, 171, 35, 234, 186
    , 64, 79, 196, 154, 223, 64, 26, 49, 144, 239, 200, 209, 118, 76, 97, 232
    , 126, 179, 28, 42, 47, 53, 241, 54, 42, 241, 70, 31, 78, 51, 176, 52
    , 219, 100, 117, 84, 121, 195, 29, 245, 39, 177, 5, 148, 100, 72, 235, 115
    , 118, 181, 127, 0, 252, 150, 248, 27, 54, 228, 156, 191, 227, 189, 80, 162
    , 146, 144, 23, 245, 25, 50, 158, 185, 44, 183, 30, 242, 109, 25, 44, 7
    , 21, 39, 139, 189, 203, 99, 6, 126, 78, 148, 251, 229, 217, 134, 112, 150
    , 33, 209, 198, 27, 154, 56, 202, 169, 72, 28, 131, 53, 64, 116, 70, 170
    , 37, 222, 37, 139, 102, 0, 119, 105, 93, 173, 239, 174, 179, 196, 124, 207
    , 146, 100, 203, 110, 56, 133, 227, 32, 36, 18, 243, 215, 75, 31, 83, 233
    , 65, 42, 156, 112, 187, 202, 243, 222, 216, 108, 164, 141, 158, 189, 208, 149
    , 106, 86, 184, 10, 43, 73, 102, 60, 11, 136, 105, 105, 235, 37, 90, 83
    , 169, 254, 98, 38, 196, 108, 44, 148, 215, 152, 51, 102, 239, 36, 197, 183
    , 186, 7, 156, 47, 27, 171, 155, 113, 149, 154, 251, 235, 114, 7, 45, 213
    , 245, 136, 36, 118, 27, 87, 163, 202, 1, 69, 7, 88, 100, 245, 250, 143
    , 55, 219, 112, 168, 122, 120, 89, 77, 124]

    // a100 signed by BlueECC

    let a100_R256: Bytes =
    [ 186, 253, 83, 137, 104, 3, 14, 231, 57, 97, 196, 198, 39, 250, 206, 34
    , 204, 30, 51, 181, 31, 192, 35, 121, 18, 228, 198, 198, 96, 86, 51, 186]
    let a100_S256: Bytes =
    [ 216, 253, 250, 170, 119, 115, 201, 150, 113, 72, 231, 1, 229, 7, 0, 177
    , 228, 165, 172, 247, 38, 96, 164, 149, 71, 10, 71, 161, 128, 27, 204, 241]
    let a100_R384: Bytes =
    [ 221, 245, 121, 84, 42, 146, 44, 220, 95, 234, 180, 26, 228, 230, 60, 139
    , 38, 228, 236, 215, 249, 87, 31, 94, 55, 216, 47, 193, 165, 235, 154, 174
    , 92, 9, 180, 28, 147, 8, 204, 82, 197, 110, 105, 213, 155, 200, 83, 241]
    let a100_S384: Bytes =
    [ 243, 116, 80, 253, 171, 247, 9, 39, 56, 188, 15, 66, 202, 64, 5, 98
    , 3, 169, 84, 237, 154, 56, 253, 191, 191, 49, 209, 183, 115, 250, 232, 251
    , 212, 50, 110, 208, 104, 130, 185, 66, 94, 53, 228, 190, 171, 40, 98, 136]
    let a100_R521: Bytes =
    [ 0, 84, 148, 127, 104, 107, 228, 44, 134, 222, 170, 183, 109, 183, 133, 117
    , 84, 131, 190, 243, 232, 70, 20, 19, 239, 229, 188, 188, 71, 184, 201, 122
    , 21, 204, 124, 169, 173, 114, 192, 192, 67, 212, 44, 133, 35, 132, 177, 77
    , 49, 115, 11, 222, 167, 192, 118, 114, 38, 26, 124, 240, 59, 143, 145, 238, 2, 157]
    let a100_S521: Bytes =
    [ 1, 79, 225, 54, 182, 251, 71, 234, 78, 217, 52, 184, 147, 119, 2, 31
    , 67, 203, 167, 174, 87, 191, 10, 170, 22, 21, 183, 43, 74, 124, 37, 118
    , 238, 202, 235, 215, 197, 112, 95, 122, 96, 46, 247, 29, 207, 42, 212, 83
    , 30, 206, 124, 135, 251, 163, 224, 14, 140, 106, 88, 90, 84, 98, 168, 29, 97, 155]

    func testDecrypt256()  throws {
        let priv256 = try ECPrivateKey(pem: priv256r1)
        let empty256 = try priv256.decrypt(msg: encryptedEmpty_256, cipher: .AES128)
        XCTAssertEqual(empty, String(bytes: empty256, encoding: .utf8))
        let fox256 = try priv256.decrypt(msg: encryptedFox_256, cipher: .AES128)
        XCTAssertEqual(fox, String(bytes: fox256, encoding: .utf8))
        let a100_256 = try priv256.decrypt(msg: encryptedA100_256, cipher: .AES128)
        XCTAssertEqual(a100, String(bytes: a100_256, encoding: .utf8))
    }
    
    func testDecrypt384() throws {
        let priv384 = try ECPrivateKey(pem: priv384r1)
        let empty384 = try priv384.decrypt(msg: encryptedEmpty_384, cipher: .AES256)
        XCTAssertEqual(empty, String(bytes: empty384, encoding: .utf8))
        let fox384 = try priv384.decrypt(msg: encryptedFox_384, cipher: .AES256)
        XCTAssertEqual(fox, String(bytes: fox384, encoding: .utf8))
        let a100_384 = try priv384.decrypt(msg: encryptedA100_384, cipher: .AES256)
        XCTAssertEqual(a100, String(bytes: a100_384, encoding: .utf8))
    }

    func testDecrypt521() throws {
        let priv521 = try ECPrivateKey(pem: priv521r1)
        let empty521 = try priv521.decrypt(msg: encryptedEmpty_521, cipher: .AES256)
        XCTAssertEqual(empty, String(bytes: empty521, encoding: .utf8))
        let fox521 = try priv521.decrypt(msg: encryptedFox_521, cipher: .AES256)
        XCTAssertEqual(fox, String(bytes: fox521, encoding: .utf8))
        let a100_521 = try priv521.decrypt(msg: encryptedA100_521, cipher: .AES256)
        XCTAssertEqual(a100, String(bytes: a100_521, encoding: .utf8))
    }

    func testVerify256() throws {
        let domain = Domain.instance(curve: .EC256r1)
        let pub256 = try ECPublicKey(pem: pub256r1)
        XCTAssert(pub256.verify(signature: ECSignature(domain: domain, r: emptyR256, s: emptyS256), msg: empty.data(using: .utf8)!))
        XCTAssert(pub256.verify(signature: ECSignature(domain: domain, r: foxR256, s: foxS256), msg: fox.data(using: .utf8)!))
        XCTAssert(pub256.verify(signature: ECSignature(domain: domain, r: a100_R256, s: a100_S256), msg: a100.data(using: .utf8)!))
    }
    
    func testVerify384() throws {
        let domain = Domain.instance(curve: .EC384r1)
        let pub384 = try ECPublicKey(pem: pub384r1)
        XCTAssert(pub384.verify(signature: ECSignature(domain: domain, r: emptyR384, s: emptyS384), msg: empty.data(using: .utf8)!))
        XCTAssert(pub384.verify(signature: ECSignature(domain: domain, r: foxR384, s: foxS384), msg: fox.data(using: .utf8)!))
        XCTAssert(pub384.verify(signature: ECSignature(domain: domain, r: a100_R384, s: a100_S384), msg: a100.data(using: .utf8)!))
    }

    func testVerify521() throws {
        let domain = Domain.instance(curve: .EC521r1)
        let pub521 = try ECPublicKey(pem: pub521r1)
        XCTAssert(pub521.verify(signature: ECSignature(domain: domain, r: emptyR521, s: emptyS521), msg: empty.data(using: .utf8)!))
        XCTAssert(pub521.verify(signature: ECSignature(domain: domain, r: foxR521, s: foxS521), msg: fox.data(using: .utf8)!))
        XCTAssert(pub521.verify(signature: ECSignature(domain: domain, r: a100_R521, s: a100_S521), msg: a100.data(using: .utf8)!))
    }

}
