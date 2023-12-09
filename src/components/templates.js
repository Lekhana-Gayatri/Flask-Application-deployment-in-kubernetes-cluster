import React, { useState, useEffect } from 'react';
import TemplateCard from './templateCard';

export default function Templates() {
  const [images, setImages] = useState([]);

  useEffect(() => {
    const loadImages = async () => {
      try {
        const promises = Array.from({ length: 21 }, async (_, i) => {
          const imageModule = await import(`./ResumeImages/${i + 1}.jpeg`);
          return imageModule.default;
        });

        const loadedImages = await Promise.all(promises);
        setImages(loadedImages);
      } catch (error) {
        console.error('Error loading images:', error);
      }
    };

    loadImages();
  }, []); // Run the effect once on component mount

  return (
    <div>
      {images.map((image, i) => (
        <TemplateCard key={i} image={image} />
      ))}
    </div>
  );
}
