// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../PackedInput.t.sol";
import "../../../src/common/KeySet.sol";
import "../../../src/common/pcs/kzg/KZG.sol";
import "../../../src/common/poly/domain/Radix2.sol";
import "../../../src/common/transcipt/Simple.sol";

contract PackedSimpleTranscriptTest is PackedInputTest {
    using SimpleTranscript for Transcript;
    using Radix2 for Radix2EvaluationDomain;
    using KZGParams for RVK;
    using KeySet for KeysetCommitment;
    using PublicInput for AccountablePublicInput;
    using BW6G1Affine for Bw6G1;
    using BW6FR for Bw6Fr;
    using PackedProtocol for SuccinctAccountableRegisterEvaluations;
    using PackedProtocol for PartialSumsAndBitmaskCommitments;
    using PackedProtocol for BitmaskPackingCommitments;

    KeysetCommitment public pks_comm;

    function setUp() public {
        pks_comm.pks_comm[0] = pks_comm_x;
        pks_comm.pks_comm[1] = pks_comm_y;
        pks_comm.log_domain_size = Radix2.LOG_N;
    }

    function test_packed_simple_transcript() public {
        AccountablePublicInput memory public_input = build_public_input();
        PackedProof memory proof = build_proof();
        Challenges memory e = build_expect_challenges();
        Transcript memory t = SimpleTranscript.init("apk_proof");
        t.set_protocol_params(Radix2.init().serialize(), KZGParams.raw_vk().serialize());
        t.set_keyset_commitment(pks_comm.serialize());
        t.append_public_input(public_input.serialize());
        t.append_register_commitments(proof.register_commitments.serialize());

        Bw6Fr memory r = t.get_bitmask_aggregation_challenge();
        assertTrue(r.eq(e.r));

        t.append_2nd_round_register_commitments(proof.additional_commitments.serialize());
        Bw6Fr memory phi = t.get_constraints_aggregation_challenge();
        assertTrue(phi.eq(e.phi));

        t.append_quotient_commitment(proof.q_comm.serialize());
        Bw6Fr memory zeta = t.get_evaluation_point();
        assertTrue(zeta.eq(e.zeta));

        t.append_evaluations(
            proof.register_evaluations.serialize(), proof.q_zeta.serialize(), proof.r_zeta_omega.serialize()
        );

        uint256 batch_size = PackedProtocol.POLYS_OPENED_AT_ZETA;
        Bw6Fr[] memory nus = t.get_kzg_aggregation_challenges(batch_size);
        for (uint256 i = 0; i < batch_size; i++) {
            assertTrue(nus[i].eq(e.nus[i]));
        }

        Transcript memory fsrng = SimpleTranscript.simple_fiat_shamir_rng(t);
        Bw6Fr memory rr = fsrng.rand_u128();
        Bw6Fr memory er = rand();
        assertTrue(er.eq(rr));

        assertEq(
            fsrng.buffer,
            hex"61706b5f70726f6f66646f6d61696e0001000000000000080000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000040b783840000d0ebe651f416b83e4f8acd6ed48f7b1ef40d19b708dff1a734acbaca74dbd94badd10b8cac01043fe3dca2842bb41cb9b00d23140c7ac8f8d9880c1ad1ae01c584d4c06b2d7133763ffae5a1ac50d0340fb9292f0001c5934edd0aea02a004874507e8450ab42a5fa6baeae39eee878a3b8f9e4ffaefbafeb5959738e0b6631c7581de413c00010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000766b5aba1fa03c90d549089e093353f1070c043e1f4872f54c772de4e2a4bce854412ee12f587aa6449ed4fd5f66379de7a761cbe061498b9d164b6eade50572c1785e815e929f818def320288d95387afec05a272135f072ff70d8ac03f0fd4ce002bfac7702340a729da3a7e3b0c045788455c845848ac6e27af9da0a34dc451be0e234e118540d056b6b585cbd859aeab1abfef212e8ce8995506c63c842196d7a4880976d983954241b07b29213e06aa247360a1f9f85766180c8b627b58e1006c524e1ceb60b6c63d135b99e14c6738738f093ac33c26920846554f256b9e1f68eed17a24d81bfa5c9ebf22179aacfd2088c4dafec5d67ad0368eea2b7f26c01cacd8b3037e33ba0276b4b01f22852d295ff523dd8f9a69bca1eeed13bd87806b65797365745f636f6d6d69746d656e74dbfa5f860754066725848619f95fd9e7f120443edcc4ea0a0071829566f19f00185c7b574551cf2684da7fea7f099566d4435066b513e69d2cf7e2aa094330b2e3484f06af49c300b451f754b1bc4b1b7f7c481aba82489d90904ffc275a7a00f593e8dfff43254d1a29b881218cfa2baaa1548a71b5a586959a8414007ff869a5893b3059b230073d3d0b1ed117d9089fb8b3981317197e99817bc434f37a27cbbe9bbf3b3fe16fb040b38ee6ed773e694bff7aea970ed3d71df03e8662a280080000007075626c69635f696e7075749ea33636de773b3fab28129e5611cd57aed9d413e84df03cb30a42b56714fffa5377efe2a13a61dc8acc39696812df000400000000000000dfffffbfeffbff7ffeffb5dffff7fffffffffffdfbfefffeeffbbfffff7bdf7f010000000000000072656769737465725f636f6d6d69746d656e747361e5205416536795a19b12678652297eace2f232bc78e60de8f13bcdf5e968d9527037a02e94a459379c3906beaadbf3735abf44feac4c14da3e0b61977b3e06ce96e83da394b0a36b578bb33d0971f011c528c09608293ad7704bc533f16f00f7175e2e76d9dd4890c288e0b0379a93528e0d2ee893907d312c6d3eb3093588df5d804ea496dfbcec987981dcdecb1724630559755ca05cc7ede9812b6f690d99c2b12fba70b83b70c85eac813263fd65f0e64f886bdc33c69a0896a70bd18010736e3a0e001b63852a5bbcb5a129695fc46609d800762a4b3df4d35f28437feab892faa300b08232759f66ae3cb8e6b572757e8f317063367b3cf716fb3b2267faa6c7bbf59b6c949042409af2fb8e7cfb151005d7b906bc0436285a22d7006269746d61736b5f6167677265676174696f6e326e645f726f756e645f72656769737465725f636f6d6d69746d656e74735efaa364621c2202c9bb977ec43d631ae6397eb613c2e9580de545922d7db79ae4cdd5203574ba3baaa2d53caf1a4f87ab497eab1ba6e094f97540026d910932338972b4e13826313d2dda56a3762d3d1e76fa2ee3208a3d9b8304ad666258800f8a52b3acfe283624f811445df4d6f64e5cceb0b581fa0fae7c0adf2a8761503ecf622eae0ddc954a554c6129b4e37899e5e1ad66a29c5baef1bcf49e1b96b25226f295559d8bc386529b362a69528e95878eab088657c2d1c1218c8af7cc00636f6e73747261696e74735f6167677265676174696f6e71756f7469656e7453c433aeb76448377a4669807f65f00e4372ee9641d7dfb63424dada0a7437686d25ebd714761134df0eec3c660313005e7dc34b5a0da521b04e4de45275f3eb4b91e51bc8e601796c4cbc786b77c3e61d07bc2f1e9e2205415924712e060c006576616c756174696f6e5f706f696e7472656769737465725f6576616c756174696f6e73b3ef82f87da1d9683da4192db5178e749037cddd529981ce851e8f76ed4bdf531edbf8e6a2961471c25bb1fb6df77400732d70699d75182999863bd61315ea475040e5e5f5488ea1c49b78988062041f5d291226a999bc57082203e2aa7f8b006f02581648e51f355a41f7c4ec0ed7443a61059239823d3d3a6f8ce3a11297856550ee8e1d91c08f3bc1ee8bf21f4500060a4d685ae45ac9995fcb282db55c96fe1f4c651fb7df94699d4978398faf5662e1c7c58b8e71c2189cba3bb1a6c90019f76d50a96b3c57dae022cc419cd5156f51c6f6e279216670dbcf0c4f48998ead7469b3eaeb494ba8fc3010473975013be5358cbc14a088545950dab471b5d7d8ccdb58e99ceed48681f8b4063ed524f5d0644522579a8830b0eefbb519780137a9f9d154f51cdbfc25b08889300010d59624bc99d9548e19acf7845ddb6ddee0098c0c0426cb1c61c29d7371ca840071756f7469656e745f6576616c756174696f6e4522b5cd74122e11c954574cf6b9cc64da002e2ac69b0c607a33e316ea0cc715c4c05cf4d73e7f5e541f5247c3903301736869667465645f6c696e656172697a6174696f6e5f6576616c756174696f6e6c8251bee11d76006990082145d96ecb8ae193887bbbc7742b1383fd81977df9008259513a4124c4006364dc84ec51006b7a675f6167677265676174696f6e6b7a675f6167677265676174696f6e6b7a675f6167677265676174696f6e6b7a675f6167677265676174696f6e6b7a675f6167677265676174696f6e6b7a675f6167677265676174696f6e6b7a675f6167677265676174696f6e6b7a675f6167677265676174696f6e76657269666965725f7365637265742a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
        );
    }
}
