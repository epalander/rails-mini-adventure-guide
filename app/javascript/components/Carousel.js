import React, { useState, useEffect } from 'react';
import CarouselSlide from './CarouselSlide';
import Slide from '@material-ui/core/Slide';
import {useStyles} from './carouselStyles'

function Arrow(props) {
    const { direction, clickFunction } = props;

    return <div onClick={clickFunction}>"Test"</div>;
}

export default function Carousel(props) {
    const { images, disableArrows } = props;
    const [index, setIndex] = useState(0);
    const content = images[index];
    const numImages = images.length
    const classes = useStyles();

    const [slideIn, setSlideIn] = useState(true);
    const [slideDirection, setSlideDirection] = useState('down');
 
    const onArrowClick = (direction) => {
        const increment = direction === 'left' ? -1 : 1;
        const newIndex = (index + increment + numImages) % numImages;

        const oppDirection = direction === 'left' ? 'right' : 'left';
        setSlideDirection(direction);
        setSlideIn(false);

        setTimeout(() => {
            setIndex(newIndex);
            setSlideDirection(oppDirection);
            setSlideIn(true);
        }, 500);
    };

    useEffect(() => {
        const handleKeyDown = (e) => {
            if (e.keyCode === 39) {
                onArrowClick('right');
            }
            if (e.keyCode === 37) {
                onArrowClick('left');
            }
        };

        window.addEventListener('keydown', handleKeyDown);

        return () => {
            window.removeEventListener('keydown', handleKeyDown);
        };
    });

    return (
        <div className={classes.carousel}>
        {disableArrows === false ?
            <Arrow
                direction='left'
                clickFunction={() => onArrowClick('left')}
            /> : null}
            <Slide in={slideIn} direction={slideDirection}>
                <div>
                    <CarouselSlide content={content} />
                </div>
            </Slide>
            {disableArrows === false ?
            <Arrow
                direction='right'
                clickFunction={() => onArrowClick('right')}
            /> : null}
        </div>
    );
}
