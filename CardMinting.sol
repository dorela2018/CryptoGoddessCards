pragma solidity ^0.4.18;

import "./CardBase.sol";

// @title all functions related to creating goddess cards
// @author Fancy Dorela (goddesscards@hotmail.com)

contract CardMinting is CardBase {
    
    // Generate non-gen0 cards, which should be combinated by two parent cards.
    // The couples can give birth to a new card, unless the couples's genes have 
    // at lest 20 BIG DIFFERENCE (means gene pieces should have distance above 200).
    // To prevent cheating, before giving birth, couples should register combination matter first and wait for
    // next blockhash been built in blockchain.
    // @param _mIdArray mother card array
    // @param _fIdArray father card array
    // @param _now create time
    function combinateCards(
        uint256[] _mIdArray,
        uint256[] _fIdArray,
        uint64 _now
    ) public onlyCEO whenNotPaused {

        uint currIndex = block.number-1;

        for (uint8 i = 0; i < _mIdArray.length; i++) {
            if(_mIdArray[i] == _fIdArray[i]) {
                continue;
            }

            uint combinationId = uint(sha256(_mIdArray[i], _fIdArray[i]));
            uint regIndex = combinationRegIndex[combinationId];
            if (regIndex == 0) {
                // not registered, go for register.
                combinationRegIndex[combinationId] = currIndex;
                continue;
            }

            if (regIndex < currIndex) {
                uint128 mGene = cards[_mIdArray[i]].genes;
                bytes16 mGene16 = bytes16(cards[_mIdArray[i]].genes);
                uint128 fGene = cards[_fIdArray[i]].genes;
                bytes16 fGene16 = bytes16(fGene);

                uint8 countOfBigPiece = 0;
                for (uint8 j = 0; j < 16; j++) {
                    if (uint8(mGene16[j]) > 200) {
                        countOfBigPiece++;
                    }
                    if (uint8(fGene16[j]) > 200) {
                        countOfBigPiece++;
                    }

                    if (countOfBigPiece > 20) {
                        break;
                    }
                }

                if (countOfBigPiece > 20) {
                    continue;
                }

                uint128 mixCode = uint128(block.blockhash(currIndex));
                uint128 cGene = mixGenes(mGene, fGene, mixCode);

                _createCard(_mIdArray[i], _fIdArray[i], cGene, ceoAddress, uint64(now));
                combinationRegIndex[combinationId] = 0;
            }            
        }
    }

    // Generate gen0 cards within limit of the number of block generated per day.
    // And the population of gen0 cards will wihin 10,000,000.
    // @param _now: trigered timestamp.
    function createGen0Cards(uint64 _now) public onlyCEO whenNotPaused {

        require(countOfGen0Created < 10000000);
        uint newHashNum = (block.number - lastGen0BlockNumber);
        require(newHashNum > 0);
        lastGen0BlockNumber = block.number;

        if (newHashNum > 5) {
            newHashNum = 5;
        }

        if (countOfGen0Created + newHashNum * 2 > 10000000) {
            newHashNum = (10000000 - countOfGen0Created)/2;
        }

        for (uint i = 0; i < newHashNum; i++) {
            uint256 hash256 = uint256(block.blockhash(block.number-1-i));
            _createCard(0, 0, uint128(hash256/(256**16)), ceoAddress, _now);
            _createCard(0, 0, uint128(hash256 % (256**16)), ceoAddress, _now);
        }

        countOfGen0Created += 2*newHashNum;
    }
    
    // In order to prevent cheating, the gene mix controll code is from next blockhash
	// coming from blockchain. Each byte in mix code switches child's gene piece taken from father or mother.
	// Last two bytes in mix code will determine which two parts of gene pieces will mutate.
    function mixGenes(uint128 mGene, uint128 fGene, uint128 mixCode ) public view returns(uint128) {
        bytes16 mGene16 = bytes16(mGene);
        bytes16 fGene16 = bytes16(fGene);
        bytes16 mixCode16 = bytes16(mixCode);
        bytes16 cGene16;
        uint128 cGene = 0;
        
        // check every byte of mixCode to decide copy from which parent.
        for (uint i = 0; i < 16; i++) {
            if (uint8(mixCode16[i]) % 2 == 1) {
                cGene = cGene*256 + uint128(mGene16[i]);
            } else {
                cGene = cGene*256 + uint128(fGene16[i]);
            }
        }
        
        // mutation
        uint8 _mix_14_id = uint8(mixCode16[14]) / 16; 
        uint8 _gene_14_id = uint8(mixCode16[14]) % 16;
        
        uint8 _mix_15_id = uint8(mixCode16[15]) / 16;
        uint8 _gene_15_id = uint8(mixCode16[15]) % 16;
        
        cGene16 = bytes16(cGene);
        
        cGene = cGene - uint128(cGene16[_gene_14_id])*(256**uint128(15-_gene_14_id)) + uint128(mixCode16[_mix_14_id])*(256**uint128(15-_gene_14_id));
        cGene = cGene - uint128(cGene16[_gene_15_id])*(256**uint128(15-_gene_15_id)) + uint128(mixCode16[_mix_15_id])*(256**uint128(15-_gene_15_id));

        return cGene;
    }
}
