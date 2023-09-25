// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "../src/Basic.sol";
import "../test/common/SimpleInput.t.sol";

contract BasicScript is Script {
    function setUp() public {}

    // 0xefec7ad40000000000000000000000000000000000000000000000000000000000000800006ff133c54b70d73a290896c028c511f071093db38b576ba3b094a33de896ce063e7b97610b3eda144cacfe44bf5a73f3dbaabe06399c3759a4942ea0377052d968e9f5cd3bf1e80de678bc32f2e2ac7e29528667129ba1956753165420e561004982772a26252e29d42b88940198394085cb34fc32b7c64ab2b6426da8fb67a4ee72ac3286bc1ef300af56312233f5f03085abcac859dfd5aca0cf6ead212b69131f49bf7fc36a67263489a5ce79f27710c5e81d5099a02910d54b0bbf236f00d10ba796089ac633dc6b884fe6f065fd633281ac5ec8703bb870ba2fb1c2990d696f2b81e9edc75ca05c755905632417cbdedc817998ecbcdf96a44e805ddf883509b33e6d2c317d9093e82e0d8e52939a37b0e088c29048ddd9762e5e17f700ef9b9632f0eb98c6274788b1c7082020bba26223a512c631a4e02d30f005954ae54f9aa01a90d9742b33b8ef43f4b2092e8c9e008c43695373691b4f77a4a304a98431231ea88af3e0a32fedc2dadd63d0b08adc12fe4ae14521d7e42358f3005c444925e0121022d976dfc866a39e2522f47d909f5a74f4b99c8a0bef3356b540e8acafce720e3cb5f728e8eceab6abef9e304220cad2b5eb7561c99d572252ecdcff58c4f73aa3b3b28a194810ec7dda490deb5e370620b7d5ad7913799e00f562cfc59c39e930ee57e447c231d24207324a4e874b88df0dbb4ce76d4635efe7bc153a9bb63a07e81b0f2be61b5f7c537d72edaa44abdbd7af811a34049e4a14dfb608f6f910c2cd1f538cbe43d4385298b544c363651ab46c1335daa5f0000000000000000000000000000000000033ec4440640b2099c6a377c99068ebb3eb8902496ee9f31c9f2219abd499f4c20f9af9f7a1ca114b2daa35dd32e93a00000000000000000000000000000000003df436cb1b376a8735b46eb680336c6d8df2b60f5bce9243f111431d224caf7a42ae4793a0c007f221acd7c48d57e3000000000000000000000000000000000057e43f6fbc9d5749a9780b02506199f98c0cc2fd65794a64432ee3f2d6616076045462d20a91280b89d10b325f516500000000000000000000000000000000000af22c86144a6c39f3107bcae7e2121bfd7307075a929b9578282ebbf216c0b2abb7dcb70a30422011204d7925256800000000000000000000000000000000005ecd342df0061e4aaaddd8af97c59d4600cc857b4bfad9d6ef6cd4ff72c671ba8b206f24645f0aa94489166fe5230e0000000000000000000000000000000000f48b1abeca5963c8907137c5e5d1d937a2042c45322b002088ed798a21540be66a7e162d41811c69f11580f30bcd4f008743380ea7b987543b0706379a06a73c43a9307dbda7abd154dd4ea107a77db7260e3aee6badbd4a0f870ff8e502b28fdad5805693f341066e217410a67e71eaf4cecf3773a30f7e7916b899a4269dab7220ad18865d95fd1dd8d8982771000076976e0225f40237144b8ab6052b3af5638f249d07422197296e2c73d574b6801a15837bc91baf154a3d528c3bd458b894955b40381f2f73aadc9b5fa28a53c766295b2deafa223b4916b9523d435e68d54b4d9b40b422d03ff7d21d04f2ee00b85aca42e6e4c7d2515fefd2f45996f068c0e9827cc97d674d97d1271789ccab75672a7018ac54f0400a54e8f3adcbf1cf82c034f2a0ab44e0183075ce807902206d63f9c29997b74a26a11c14331fe33ba3fc8100c4b7212d53f1a5c9b91100bf881fbcf359197cd337fa1228cd1792e6f7b50d78dda2a117d647b0740b015f54ca1c008eed25dcd1d0185454c852010a960b736e1ed5507ad9d10efcd8a57143320b0a18938fdfcf0440727b6da8d55587b942e68e6fae8e7122ca588d540000000000000000000000000000000000e3f01ca6ff6209cfc4b5f76939854d983a2e2e7300a4c19ba84edbce27a4279be484b2a7a1943c30a72ba6f8265e22000000000000000000000000000000000079cc7b2a270ac9befcb0b47f6654afa3f9b97216acd16739ae6762473c7362f10cf8b906832bd22fe51decbed578eb00000000000000000000000000000000003b9231248eb5337b3e9f028c073efe7e015f17545cde1d30bbdc0f231d16fad24cd6716b28b3329112a9306d05c1d1000000000000000000000000000000000060fafb9c430873a186e529aae8adc707326665a45b3b656104c4eecaea70fe7f8ed13c897baadea4ade0955d6e4e390017214fa29ac9806a5730f174a0ed1e5821f8eb491841608ce8b29ff079dc952134cac3155c23a1c173764d4322edbb4ee7a275ba770623b836deac0c1e22ff77cf494a270946ea7888dba523265dc84416571fc0daec31bebec0fc8204f8a100528af0c701b93d94bc0620b0c61432a04cb0f4ed13aa479932cc9690aa34d610d9b2df89e7a972aac8b6b9e939983fd937ccbbedab777aeb7c8520617db09741a1b8dfd3bdc2ff742c0ef4094468b4e479533918057a00e4128859fb2498e500b26d4c805b675207e1280359ac671f3e493d0c779322680b368df0ac03205d1328e8691f00789856d9356805b0cd6f50f84c4be96b1d0cb3236ad02ba632ee1f22a9559fcf547b647d86bd1b260db7dd78ff26c9ae85acef71c3465375dc78003d16f8ed12a5a40226a4d9e2a1a054f1f21ed2c498a00f7523ea8fc33790f6e661d44f017e4a6f85adcf77d2eca96c60fdc9de9d665eb87d8b731ca7700711f465a60b2bd0dc8404004ef5575d20952ba2e187cc8330ae86f0366b45be7a3400000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000df12686939cc8adc613aa1e2ef7753faff1467b5420ab33cf04de813d4d9ae57cd11569e1228ab3f3b77de3636a39e0000000000000000000000000000000000c7b39a036437b74c03aacbb1ed26fcab84a985e21baca9e1d873c8d7a9a8eca08ce79d32ac6edbefb8c43e7b62b6b600000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000017fdf7bffffbffbeffefffefbfdfffffffffff7ffdfb5fffe7ffffbefbfffffdf
    // Gas used: 13572505
    function run() public {
        SimpleInputTest s = new SimpleInputTest();
        vm.startBroadcast();
        Bw6G1[2] memory pks_comm = s.build_pks_comm();
        new Basic(pks_comm);
        vm.stopBroadcast();
    }
}
